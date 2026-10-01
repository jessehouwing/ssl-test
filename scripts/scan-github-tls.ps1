#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Scan the TLS configuration of the GitHub endpoints advertised by the
    https://api.github.com/meta endpoint and report which of them are
    post-quantum (hybrid ML-KEM key exchange) ready.

.DESCRIPTION
    Requires OpenSSL 3.5 or newer on PATH (for the ML-KEM hybrid groups).
    PowerShell 7.2+ is required.

.PARAMETER MetaUrl
    URL of the meta endpoint.

.PARAMETER MetaFile
    Use a local meta JSON file instead of downloading it.

.PARAMETER GitHubHost
    Hostname of a GitHub instance to query via `gh api meta --hostname`
    instead of downloading MetaUrl directly. Useful for GitHub Enterprise
    Cloud with data residency, where the meta endpoint is not a plain REST
    route and `gh` already holds a valid token for the host.

.PARAMETER OutputDir
    Directory for the generated report.

.PARAMETER PqGroups
    Hybrid groups to probe.

.PARAMETER MaxHosts
    Maximum number of hosts to scan, 0 means no limit.

.PARAMETER Port
    TLS port to connect to.

.PARAMETER ConnectTimeout
    Timeout in seconds for a single handshake.

.PARAMETER GitHubToken
    Optional token used to authenticate the meta request (needed for GitHub
    Enterprise Cloud with data residency).
#>
#Requires -Version 7.2
[CmdletBinding()]
param(
    [string] $MetaUrl = $(if ($env:META_URL) { $env:META_URL } else { 'https://api.github.com/meta' }),
    [string] $MetaFile = $env:META_FILE,
    [string] $GitHubHost = $env:GH_HOST,
    [string] $OutputDir = $(if ($env:OUTPUT_DIR) { $env:OUTPUT_DIR } else { './tls-report' }),
    [string[]] $PqGroups = $(if ($env:PQ_GROUPS) { $env:PQ_GROUPS -split '\s+' } else { @('X25519MLKEM768', 'SecP256r1MLKEM768', 'SecP384r1MLKEM1024') }),
    [int] $MaxHosts = $(if ($env:MAX_HOSTS) { [int]$env:MAX_HOSTS } else { 0 }),
    [int] $Port = $(if ($env:PORT) { [int]$env:PORT } else { 443 }),
    [int] $ConnectTimeout = $(if ($env:CONNECT_TIMEOUT) { [int]$env:CONNECT_TIMEOUT } else { 10 }),
    [string] $GitHubToken = $env:GITHUB_TOKEN
)

$ErrorActionPreference = 'Stop'

function Write-Log {
    param([string] $Message)
    [Console]::Error.WriteLine($Message)
}

# Recursively yields every string leaf of a JSON value parsed by ConvertFrom-Json.
function Get-StringLeaf {
    param($Node)
    if ($null -eq $Node) { return }
    if ($Node -is [string]) {
        $Node
    }
    elseif ($Node -is [System.Management.Automation.PSCustomObject]) {
        foreach ($prop in $Node.PSObject.Properties) { Get-StringLeaf $prop.Value }
    }
    elseif ($Node -is [System.Collections.IEnumerable]) {
        foreach ($item in $Node) { Get-StringLeaf $item }
    }
}

function Get-Field {
    param([string] $Output, [string] $Label)
    $match = [regex]::Match($Output, "(?m)^\s*$([regex]::Escape($Label)):\s*(.*)$")
    if ($match.Success) { return $match.Groups[1].Value.Trim() }
    return ''
}

# OpenSSL reports the key exchange as "Negotiated TLS1.3 group" for the hybrid
# ML-KEM groups and as "Peer Temp Key: <group>, <n> bits" otherwise.
function Get-NegotiatedGroup {
    param([string] $Output)
    $value = Get-Field $Output 'Negotiated TLS1.3 group'
    if ([string]::IsNullOrEmpty($value)) {
        $peerTemp = Get-Field $Output 'Peer Temp Key'
        if ($peerTemp) { $value = ($peerTemp -split ',')[0].Trim() }
    }
    return $value
}

function Test-HandshakeOk {
    param([string] $Output)
    return [regex]::IsMatch($Output, '(?m)^Protocol version:')
}

# Runs `openssl s_client -brief` against a host and returns its combined output,
# killing the process if it does not finish within $ConnectTimeout seconds.
function Invoke-OpenSslSClient {
    param(
        [Parameter(Mandatory)] [string] $TargetHost,
        [string[]] $ExtraArgs = @()
    )

    $stdOutFile = [System.IO.Path]::GetTempFileName()
    $stdErrFile = [System.IO.Path]::GetTempFileName()
    $inputFile = [System.IO.Path]::GetTempFileName()
    Set-Content -Path $inputFile -Value 'Q' -NoNewline

    $argumentList = @('s_client', '-connect', "${TargetHost}:${Port}", '-servername', $TargetHost, '-brief') + $ExtraArgs
    try {
        $proc = Start-Process -FilePath openssl -ArgumentList $argumentList `
            -RedirectStandardInput $inputFile -RedirectStandardOutput $stdOutFile -RedirectStandardError $stdErrFile `
            -NoNewWindow -PassThru
        if (-not $proc.WaitForExit($ConnectTimeout * 1000)) {
            try { Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue } catch {}
            $proc.WaitForExit()
        }
        $output = (Get-Content -Path $stdOutFile -Raw -ErrorAction SilentlyContinue) + (Get-Content -Path $stdErrFile -Raw -ErrorAction SilentlyContinue)
        return $output
    }
    finally {
        Remove-Item -Path $stdOutFile, $stdErrFile, $inputFile -ErrorAction SilentlyContinue
    }
}

# --- setup -------------------------------------------------------------------

New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
$report = Join-Path $OutputDir 'github-tls-report.md'
$csv = Join-Path $OutputDir 'github-tls-report.csv'
$hostPattern = '^[a-z0-9]([a-z0-9-]*[a-z0-9])?(\.[a-z0-9]([a-z0-9-]*[a-z0-9])?)+$'

# --- collect the host names --------------------------------------------------

if ($MetaFile) {
    Write-Log "Using local meta file: $MetaFile"
    $metaContent = Get-Content -Path $MetaFile -Raw
}
elseif ($GitHubHost) {
    Write-Log "Querying meta via: gh api meta --hostname $GitHubHost"
    $metaContent = (& gh api meta --hostname $GitHubHost) -join "`n"
    if ($LASTEXITCODE -ne 0) {
        Write-Log "gh api meta failed for host $GitHubHost"
        exit 1
    }
}
else {
    Write-Log "Downloading $MetaUrl"
    $headers = @{
        'Accept'               = 'application/vnd.github+json'
        'X-GitHub-Api-Version' = '2022-11-28'
    }
    if ($GitHubToken) { $headers['Authorization'] = "Bearer $GitHubToken" }
    $metaContent = (Invoke-WebRequest -Uri $MetaUrl -Headers $headers -UseBasicParsing).Content
}

$meta = $metaContent | ConvertFrom-Json
$domains = $meta.domains

# `.domains` contains nested objects/arrays of domain names, some of them
# wildcards (`*.github.com`) which cannot be connected to directly.
$hostNames = Get-StringLeaf $domains |
    ForEach-Object { $_.ToLowerInvariant() -replace '^\*\.', '' } |
    Where-Object { $_ -match $hostPattern } |
    Sort-Object -Unique

if (-not $hostNames) {
    Write-Log 'No host names found in the meta response'
    exit 1
}

if ($MaxHosts -gt 0) {
    $hostNames = $hostNames | Select-Object -First $MaxHosts
}

Write-Log "Scanning $($hostNames.Count) host(s)"

# --- probe helpers ------------------------------------------------------------

$opensslVersion = (& openssl version).Trim()
$availableGroups = (& openssl list -tls-groups 2>$null) -join "`n" -split ':' | ForEach-Object { $_.Trim().ToLowerInvariant() }

$supportedPqGroups = @()
foreach ($group in $PqGroups) {
    if ($availableGroups -contains $group.ToLowerInvariant()) {
        $supportedPqGroups += $group
    }
    else {
        Write-Log "WARNING: $opensslVersion does not support the group $group, skipping it"
    }
}

# --- scan ----------------------------------------------------------------------

$results = [System.Collections.Generic.List[pscustomobject]]::new()

foreach ($hostName in $hostNames) {
    Write-Log "-> $hostName"

    $defaultOut = Invoke-OpenSslSClient -TargetHost $hostName
    if (-not (Test-HandshakeOk $defaultOut)) {
        $results.Add([pscustomobject]@{
            host        = $hostName
            tls13       = 'no'
            tls12       = 'no'
            protocol    = ''
            ciphersuite = ''
            group       = ''
            signature   = ''
            pq_group    = ''
        })
        continue
    }

    $protocol = Get-Field $defaultOut 'Protocol version'
    $ciphersuite = Get-Field $defaultOut 'Ciphersuite'
    $group = Get-NegotiatedGroup $defaultOut
    $signature = Get-Field $defaultOut 'Signature type'

    $tls13 = 'no'
    if ($protocol -eq 'TLSv1.3' -or (Test-HandshakeOk (Invoke-OpenSslSClient -TargetHost $hostName -ExtraArgs @('-tls1_3')))) {
        $tls13 = 'yes'
    }

    $tls12 = 'no'
    if (Test-HandshakeOk (Invoke-OpenSslSClient -TargetHost $hostName -ExtraArgs @('-tls1_2'))) {
        $tls12 = 'yes'
    }

    $pqGroup = ''
    if ($tls13 -eq 'yes') {
        foreach ($candidate in $supportedPqGroups) {
            $pqOut = Invoke-OpenSslSClient -TargetHost $hostName -ExtraArgs @('-tls1_3', '-groups', $candidate)
            if ((Test-HandshakeOk $pqOut) -and (Get-NegotiatedGroup $pqOut) -eq $candidate) {
                $pqGroup = $candidate
                break
            }
        }
    }

    $results.Add([pscustomobject]@{
        host        = $hostName
        tls13       = $tls13
        tls12       = $tls12
        protocol    = $protocol
        ciphersuite = $ciphersuite
        group       = $group
        signature   = $signature
        pq_group    = $pqGroup
    })
}

$results | Export-Csv -Path $csv -NoTypeInformation

# --- report ----------------------------------------------------------------------

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('# GitHub TLS configuration report')
$lines.Add('')
$lines.Add("- Source: ``$(if ($MetaFile) { $MetaFile } elseif ($GitHubHost) { "gh api meta --hostname $GitHubHost" } else { $MetaUrl })``")
$lines.Add("- Generated: $([DateTime]::UtcNow.ToString('yyyy-MM-ddTHH:mm:ssZ'))")
$lines.Add("- Scanner: ``$opensslVersion``")
$lines.Add("- Probed post-quantum groups: ``$(if ($supportedPqGroups) { $supportedPqGroups -join ' ' } else { 'none' })``")
$lines.Add('')
$lines.Add('## TLS configuration per endpoint')
$lines.Add('')
$lines.Add('| Endpoint | TLS 1.3 | TLS 1.2 | Negotiated protocol | Ciphersuite | Key exchange group | Certificate signature | Post-quantum group |')
$lines.Add('| --- | --- | --- | --- | --- | --- | --- | --- |')
foreach ($r in $results) {
    if (-not $r.protocol) {
        $lines.Add("| ``$($r.host)`` | no | no | _no TLS handshake_ | | | | |")
    }
    else {
        $lines.Add("| ``$($r.host)`` | $($r.tls13) | $($r.tls12) | $($r.protocol) | $($r.ciphersuite) | $($r.group) | $($r.signature) | $(if ($r.pq_group) { $r.pq_group } else { 'no' }) |")
    }
}
$lines.Add('')
$lines.Add('## Post-quantum ready TLS setups')
$lines.Add('')
$pqResults = $results | Where-Object { $_.pq_group }
if (-not $pqResults) {
    $lines.Add('No endpoint negotiated a hybrid ML-KEM key exchange.')
}
else {
    $lines.Add('| Endpoint | Protocol | Ciphersuite | Hybrid key exchange | Certificate signature |')
    $lines.Add('| --- | --- | --- | --- | --- |')
    foreach ($r in $pqResults) {
        $lines.Add("| ``$($r.host)`` | TLSv1.3 | $($r.ciphersuite) | $($r.pq_group) | $($r.signature) |")
    }
}
$lines.Add('')
$lines.Add('## Endpoints without post-quantum key exchange')
$lines.Add('')
$classicResults = $results | Where-Object { -not $_.pq_group }
if (-not $classicResults) {
    $lines.Add('All scanned endpoints support a hybrid ML-KEM key exchange.')
}
else {
    foreach ($r in $classicResults) {
        if (-not $r.protocol) {
            $lines.Add("- ``$($r.host)`` (no TLS handshake)")
        }
        else {
            $lines.Add("- ``$($r.host)`` ($($r.protocol), group $(if ($r.group) { $r.group } else { 'n/a' }))")
        }
    }
}

$reportText = $lines -join "`n"
Set-Content -Path $report -Value $reportText

Write-Log "Report written to $report"
Write-Output $reportText
