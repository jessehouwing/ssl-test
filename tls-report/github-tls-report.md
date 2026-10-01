# GitHub TLS configuration report

- Source: `gh api meta --hostname xebia-partner-dr.ghe.com`
- Generated: 2026-10-01T09:25:56Z
- Scanner: `OpenSSL 3.5.7 9 Jun 2026 (Library: OpenSSL 3.5.7 9 Jun 2026)`
- Probed post-quantum groups: `X25519MLKEM768 SecP256r1MLKEM768 SecP384r1MLKEM1024`

## TLS configuration per endpoint

| Endpoint | TLS 1.3 | TLS 1.2 | Negotiated protocol | Ciphersuite | Key exchange group | Certificate signature | Post-quantum group |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `actions.githubusercontent.com` | no | no | _no TLS handshake_ | | | | |
| `actions.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `api.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `aumprodweu01.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `broker.actions.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `codeload.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `containers.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `copilotweu01activity.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `copilotweu01attachments.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `core.windows.net` | no | no | _no TLS handshake_ | | | | |
| `dgpprodweu01.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `eaprodweu.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `fulcio.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `ghcsmrvaprodweu01.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `github-raw.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `github.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | ecdsa_secp256r1_sha256 | no |
| `githubapp.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `githubusercontent.com` | no | no | _no TLS handshake_ | | | | |
| `hosted-compute-request-orchestrator-prod-weu-01.githubapp.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `launch-receiver.actions.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `maven.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `mbprodweu01.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `memoryalphaprodweu01.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `migratorexportsprodweu01.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `mpsghub.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `mvnabsprodweu0137d3.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `mvnabsprodweu01c91d.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `npm.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `nuget.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `objects-origin.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus10.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus11.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus12.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus13.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus14.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus15.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus2.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus20.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus21.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus22.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus23.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus24.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus25.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus26.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus3.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus4.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus5.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus6.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus7.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus8.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesghubeus9.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesproxcnc1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesproxcus1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesproxeau1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesproxjpw1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesproxsdc1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesproxweu1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesproxwus31.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pipelinesproxwus32.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `pkg.actions.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `prodweu01resultssa0.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `prodweu01resultssa1.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `prodweu01resultssa2.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `prodweu01resultssa3.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `proximawesteucontainer.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `proximawesteunpm.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `proximawesteunuget.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `proximawesteurubygems.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `pypi.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `release-assets.githubusercontent.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519MLKEM768 | rsa_pss_rsae_sha256 | X25519MLKEM768 |
| `results-receiver.actions.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `rubygems.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `run-proxima-1-prod-weu-01-az1.actions.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `run-proxima-1-prod-weu-01-az2.actions.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `run-proxima-1-prod-weu-01-az3.actions.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `runnerghubeus1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `runnerghubeus20.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `runnerghubeus21.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `runnerghubwus31.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `runnerproxcnc1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `runnerproxcus1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `runnerproxeau1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `runnerproxjpw1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `runnerproxsdc1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `runnerproxweu1.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `securitycenterexportweu.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `setup-tools.actions.githubusercontent.com` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `swift.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `timestamp.xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |
| `tmaprodweu01.blob.core.windows.net` | yes | yes | TLSv1.3 | TLS_AES_256_GCM_SHA384 | ECDH | rsa_pss_rsae_sha256 | no |
| `tokenghub.actions.githubusercontent.com` | no | yes | TLSv1.2 | ECDHE-RSA-AES256-GCM-SHA384 | X25519 | rsa_pss_rsae_sha256 | no |
| `tuf-repo.github.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519MLKEM768 | rsa_pss_rsae_sha256 | X25519MLKEM768 |
| `xebia-partner-dr.ghe.com` | yes | yes | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519 | rsa_pss_rsae_sha256 | no |

## Post-quantum ready TLS setups

| Endpoint | Protocol | Ciphersuite | Hybrid key exchange | Certificate signature |
| --- | --- | --- | --- | --- |
| `release-assets.githubusercontent.com` | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519MLKEM768 | rsa_pss_rsae_sha256 |
| `tuf-repo.github.com` | TLSv1.3 | TLS_AES_128_GCM_SHA256 | X25519MLKEM768 | rsa_pss_rsae_sha256 |

## Endpoints without post-quantum key exchange

- `actions.githubusercontent.com` (no TLS handshake)
- `actions.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `api.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `aumprodweu01.blob.core.windows.net` (TLSv1.3, group ECDH)
- `broker.actions.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `codeload.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `containers.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `copilotweu01activity.blob.core.windows.net` (TLSv1.3, group ECDH)
- `copilotweu01attachments.blob.core.windows.net` (TLSv1.3, group ECDH)
- `core.windows.net` (no TLS handshake)
- `dgpprodweu01.blob.core.windows.net` (TLSv1.3, group ECDH)
- `eaprodweu.blob.core.windows.net` (TLSv1.3, group ECDH)
- `fulcio.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `ghcsmrvaprodweu01.blob.core.windows.net` (TLSv1.3, group ECDH)
- `github-raw.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `github.com` (TLSv1.3, group X25519)
- `githubapp.com` (TLSv1.3, group X25519)
- `githubusercontent.com` (no TLS handshake)
- `hosted-compute-request-orchestrator-prod-weu-01.githubapp.com` (TLSv1.3, group X25519)
- `launch-receiver.actions.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `maven.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `mbprodweu01.blob.core.windows.net` (TLSv1.3, group ECDH)
- `memoryalphaprodweu01.blob.core.windows.net` (TLSv1.3, group ECDH)
- `migratorexportsprodweu01.blob.core.windows.net` (TLSv1.3, group ECDH)
- `mpsghub.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `mvnabsprodweu0137d3.blob.core.windows.net` (TLSv1.3, group ECDH)
- `mvnabsprodweu01c91d.blob.core.windows.net` (TLSv1.3, group ECDH)
- `npm.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `nuget.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `objects-origin.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `pipelinesghubeus1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus10.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus11.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus12.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus13.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus14.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus15.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus2.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus20.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus21.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus22.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus23.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus24.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus25.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus26.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus3.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus4.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus5.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus6.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus7.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus8.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesghubeus9.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesproxcnc1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesproxcus1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesproxeau1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesproxjpw1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesproxsdc1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesproxweu1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesproxwus31.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pipelinesproxwus32.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `pkg.actions.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `prodweu01resultssa0.blob.core.windows.net` (TLSv1.3, group ECDH)
- `prodweu01resultssa1.blob.core.windows.net` (TLSv1.3, group ECDH)
- `prodweu01resultssa2.blob.core.windows.net` (TLSv1.3, group ECDH)
- `prodweu01resultssa3.blob.core.windows.net` (TLSv1.3, group ECDH)
- `proximawesteucontainer.blob.core.windows.net` (TLSv1.3, group ECDH)
- `proximawesteunpm.blob.core.windows.net` (TLSv1.3, group ECDH)
- `proximawesteunuget.blob.core.windows.net` (TLSv1.3, group ECDH)
- `proximawesteurubygems.blob.core.windows.net` (TLSv1.3, group ECDH)
- `pypi.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `results-receiver.actions.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `rubygems.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `run-proxima-1-prod-weu-01-az1.actions.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `run-proxima-1-prod-weu-01-az2.actions.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `run-proxima-1-prod-weu-01-az3.actions.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `runnerghubeus1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `runnerghubeus20.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `runnerghubeus21.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `runnerghubwus31.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `runnerproxcnc1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `runnerproxcus1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `runnerproxeau1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `runnerproxjpw1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `runnerproxsdc1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `runnerproxweu1.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `securitycenterexportweu.blob.core.windows.net` (TLSv1.3, group ECDH)
- `setup-tools.actions.githubusercontent.com` (TLSv1.3, group ECDH)
- `swift.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `timestamp.xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
- `tmaprodweu01.blob.core.windows.net` (TLSv1.3, group ECDH)
- `tokenghub.actions.githubusercontent.com` (TLSv1.2, group X25519)
- `xebia-partner-dr.ghe.com` (TLSv1.3, group X25519)
