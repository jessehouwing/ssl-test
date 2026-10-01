#!/bin/sh
# Scan the TLS configuration of the GitHub endpoints advertised by the
# https://api.github.com/meta endpoint and report which of them are
# post-quantum (hybrid ML-KEM key exchange) ready.
#
# Requires: curl, jq and OpenSSL 3.5 or newer (for the ML-KEM hybrid groups).
#
# Environment variables:
#   META_URL     URL of the meta endpoint (default: https://api.github.com/meta)
#   META_FILE    Use a local meta JSON file instead of downloading it
#   OUTPUT_DIR   Directory for the generated report (default: ./tls-report)
#   PQ_GROUPS    Space separated hybrid groups to probe
#                (default: "X25519MLKEM768 SecP256r1MLKEM768 SecP384r1MLKEM1024")
#   MAX_HOSTS    Maximum number of hosts to scan, 0 means no limit (default: 0)
#   PORT         TLS port to connect to (default: 443)
#   CONNECT_TIMEOUT  Timeout in seconds for a single handshake (default: 10)
#   GITHUB_TOKEN     Optional token used to authenticate the meta request
#                    (needed for GitHub Enterprise Cloud with data residency)

set -eu

META_URL=${META_URL:-https://api.github.com/meta}
META_FILE=${META_FILE:-}
OUTPUT_DIR=${OUTPUT_DIR:-./tls-report}
PQ_GROUPS=${PQ_GROUPS:-"X25519MLKEM768 SecP256r1MLKEM768 SecP384r1MLKEM1024"}
MAX_HOSTS=${MAX_HOSTS:-0}
PORT=${PORT:-443}
CONNECT_TIMEOUT=${CONNECT_TIMEOUT:-10}

WORK_DIR=$(mktemp -d)
trap 'rm -rf "$WORK_DIR"' EXIT

mkdir -p "$OUTPUT_DIR"
REPORT="$OUTPUT_DIR/github-tls-report.md"
CSV="$OUTPUT_DIR/github-tls-report.csv"

log() { printf '%s\n' "$*" >&2; }

# --- collect the host names -------------------------------------------------

meta_json="$WORK_DIR/meta.json"
if [ -n "$META_FILE" ]; then
  log "Using local meta file: $META_FILE"
  cp "$META_FILE" "$meta_json"
else
  log "Downloading $META_URL"
  curl --fail --silent --show-error \
    --header 'Accept: application/vnd.github+json' \
    --header 'X-GitHub-Api-Version: 2022-11-28' \
    ${GITHUB_TOKEN:+--header "Authorization: Bearer $GITHUB_TOKEN"} \
    "$META_URL" -o "$meta_json"
fi

hosts="$WORK_DIR/hosts.txt"
# `.domains` contains nested objects/arrays of domain names, some of them
# wildcards (`*.github.com`) which cannot be connected to directly.
jq -r '.domains // {} | [.. | strings] | .[]' "$meta_json" \
  | tr '[:upper:]' '[:lower:]' \
  | sed 's/^\*\.//' \
  | grep -E '^[a-z0-9]([a-z0-9-]*[a-z0-9])?(\.[a-z0-9]([a-z0-9-]*[a-z0-9])?)+$' \
  | sort -u > "$hosts" || true

if [ ! -s "$hosts" ]; then
  log "No host names found in the meta response"
  exit 1
fi

if [ "$MAX_HOSTS" -gt 0 ]; then
  head -n "$MAX_HOSTS" "$hosts" > "$hosts.limited"
  mv "$hosts.limited" "$hosts"
fi

log "Scanning $(wc -l < "$hosts" | tr -d ' ') host(s)"

# --- probe helpers ----------------------------------------------------------

openssl_version=$(openssl version)
available_groups=$(openssl list -tls-groups 2>/dev/null | tr ':' '\n' | tr '[:upper:]' '[:lower:]' || true)

supported_pq_groups=""
for group in $PQ_GROUPS; do
  if printf '%s\n' "$available_groups" | grep -qx "$(printf '%s' "$group" | tr '[:upper:]' '[:lower:]')"; then
    supported_pq_groups="$supported_pq_groups $group"
  else
    log "WARNING: $openssl_version does not support the group $group, skipping it"
  fi
done
supported_pq_groups=${supported_pq_groups# }

# connect <host> [extra openssl args...] -> prints `openssl s_client -brief` output
connect() {
  host=$1
  shift
  printf 'Q\n' | timeout "$CONNECT_TIMEOUT" openssl s_client \
    -connect "$host:$PORT" \
    -servername "$host" \
    -brief \
    "$@" 2>&1 || true
}

field() {
  # field <output> <label>
  printf '%s\n' "$1" | sed -n "s/^ *$2: *//p" | head -n 1
}

group_of() {
  # OpenSSL reports the key exchange as "Negotiated TLS1.3 group" for the
  # hybrid ML-KEM groups and as "Peer Temp Key: <group>, <n> bits" otherwise.
  value=$(field "$1" 'Negotiated TLS1.3 group')
  if [ -z "$value" ]; then
    value=$(field "$1" 'Peer Temp Key' | cut -d, -f1)
  fi
  printf '%s' "$value"
}

handshake_ok() {
  printf '%s\n' "$1" | grep -q '^Protocol version:'
}

# --- scan -------------------------------------------------------------------

results="$WORK_DIR/results.csv"
printf 'host,tls13,tls12,protocol,ciphersuite,group,signature,pq_group\n' > "$results"

while IFS= read -r host; do
  [ -n "$host" ] || continue
  log "-> $host"

  default_out=$(connect "$host")
  if ! handshake_ok "$default_out"; then
    printf '%s,no,no,,,,,\n' "$host" >> "$results"
    continue
  fi

  protocol=$(field "$default_out" 'Protocol version')
  ciphersuite=$(field "$default_out" 'Ciphersuite')
  group=$(group_of "$default_out")
  signature=$(field "$default_out" 'Signature type')

  tls13=no
  if [ "$protocol" = "TLSv1.3" ] || handshake_ok "$(connect "$host" -tls1_3)"; then
    tls13=yes
  fi

  tls12=no
  if handshake_ok "$(connect "$host" -tls1_2)"; then
    tls12=yes
  fi

  pq_group=""
  if [ "$tls13" = yes ]; then
    for candidate in $supported_pq_groups; do
      pq_out=$(connect "$host" -tls1_3 -groups "$candidate")
      if handshake_ok "$pq_out" && \
         [ "$(group_of "$pq_out")" = "$candidate" ]; then
        pq_group=$candidate
        break
      fi
    done
  fi

  printf '%s,%s,%s,%s,%s,%s,%s,%s\n' \
    "$host" "$tls13" "$tls12" "$protocol" "$ciphersuite" "$group" "$signature" "$pq_group" \
    >> "$results"
done < "$hosts"

cp "$results" "$CSV"

# --- report -----------------------------------------------------------------

{
  echo "# GitHub TLS configuration report"
  echo
  echo "- Source: \`${META_FILE:-$META_URL}\`"
  echo "- Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo "- Scanner: \`$openssl_version\`"
  echo "- Probed post-quantum groups: \`${supported_pq_groups:-none}\`"
  echo
  echo "## TLS configuration per endpoint"
  echo
  echo "| Endpoint | TLS 1.3 | TLS 1.2 | Negotiated protocol | Ciphersuite | Key exchange group | Certificate signature | Post-quantum group |"
  echo "| --- | --- | --- | --- | --- | --- | --- | --- |"
  tail -n +2 "$results" | while IFS=, read -r host tls13 tls12 protocol ciphersuite group signature pq_group; do
    if [ -z "$protocol" ]; then
      echo "| \`$host\` | no | no | _no TLS handshake_ | | | | |"
    else
      echo "| \`$host\` | $tls13 | $tls12 | $protocol | $ciphersuite | $group | $signature | ${pq_group:-no} |"
    fi
  done
  echo
  echo "## Post-quantum ready TLS setups"
  echo
  pq_count=$(tail -n +2 "$results" | awk -F, '$8 != "" { count++ } END { print count + 0 }')
  if [ "$pq_count" -eq 0 ]; then
    echo "No endpoint negotiated a hybrid ML-KEM key exchange."
  else
    echo "| Endpoint | Protocol | Ciphersuite | Hybrid key exchange | Certificate signature |"
    echo "| --- | --- | --- | --- | --- |"
    tail -n +2 "$results" | while IFS=, read -r host tls13 tls12 protocol ciphersuite group signature pq_group; do
      [ -n "$pq_group" ] || continue
      echo "| \`$host\` | TLSv1.3 | $ciphersuite | $pq_group | $signature |"
    done
  fi
  echo
  echo "## Endpoints without post-quantum key exchange"
  echo
  classic_count=$(tail -n +2 "$results" | awk -F, '$8 == "" { count++ } END { print count + 0 }')
  if [ "$classic_count" -eq 0 ]; then
    echo "All scanned endpoints support a hybrid ML-KEM key exchange."
  else
    tail -n +2 "$results" | while IFS=, read -r host tls13 tls12 protocol ciphersuite group signature pq_group; do
      [ -z "$pq_group" ] || continue
      if [ -z "$protocol" ]; then
        echo "- \`$host\` (no TLS handshake)"
      else
        echo "- \`$host\` ($protocol, group ${group:-n/a})"
      fi
    done
  fi
} > "$REPORT"

log "Report written to $REPORT"
cat "$REPORT"
