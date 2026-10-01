# ssl-test
Example tooling that inspects the TLS configuration of the GitHub endpoints
published by the [`api.github.com/meta`](https://docs.github.com/rest/meta/meta)
endpoint and reports which of them already offer a **post-quantum** (hybrid
ML-KEM) key exchange.

## Workflow

[`.github/workflows/github-tls-scan.yml`](.github/workflows/github-tls-scan.yml)
can be started manually (`workflow_dispatch`) and also runs whenever the scanner
itself changes (`push`). It runs in an `alpine:3.22` container because that image
ships OpenSSL 3.5, which supports the hybrid ML-KEM groups
(`X25519MLKEM768`, `SecP256r1MLKEM768`, `SecP384r1MLKEM1024`).

The report is written to the job summary and uploaded as the
`github-tls-report` artifact (Markdown + CSV).

## Running locally

Requires PowerShell 7.2+ and OpenSSL 3.5 or newer:

```pwsh
./scripts/scan-github-tls.ps1
```

Or, without a local OpenSSL 3.5, using the same Alpine image as the workflow:

```pwsh
docker run --rm -v "${PWD}:/repo" -w /repo alpine:3.22 sh -c @'
  apk add --no-cache curl openssl ca-certificates less ncurses-terminfo-base krb5-libs libgcc libintl libssl3 libstdc++ tzdata userspace-rcu zlib icu-libs
  curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.4.20/powershell-7.4.20-linux-musl-x64.tar.gz -o /tmp/pwsh.tar.gz
  mkdir -p /opt/microsoft/powershell/7 && tar zxf /tmp/pwsh.tar.gz -C /opt/microsoft/powershell/7
  ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
  pwsh ./scripts/scan-github-tls.ps1
'@
```

### Options

| Variable | Default | Description |
| --- | --- | --- |
| `META_URL` | `https://api.github.com/meta` | Meta endpoint to read the endpoint list from |
| `META_FILE` | _(unset)_ | Use a local meta JSON file instead of downloading it |
| `OUTPUT_DIR` | `./tls-report` | Directory for the generated report |
| `PORT` | `443` | TLS port to connect to |
| `PQ_GROUPS` | `X25519MLKEM768 SecP256r1MLKEM768 SecP384r1MLKEM1024` | Hybrid groups to probe |
| `MAX_HOSTS` | `0` | Maximum number of endpoints to scan (`0` = all) |
| `CONNECT_TIMEOUT` | `10` | Timeout in seconds for a single handshake |

Each option is also available as a matching script parameter, e.g.
`./scripts/scan-github-tls.ps1 -MaxHosts 5`.

## Report

For every host name found in the `domains` section of the meta response the
scanner records whether TLS 1.3 and TLS 1.2 are accepted, the negotiated
protocol, ciphersuite, key exchange group and certificate signature algorithm,
and whether a hybrid ML-KEM key exchange can be negotiated. The report ends with
the list of post-quantum ready TLS setups and the endpoints that still only
offer classical key exchange.
