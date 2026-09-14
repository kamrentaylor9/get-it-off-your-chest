#!/usr/bin/env bash
# record.sh <tier> <source> <symbol> <name> <price> <change_ratio> <volume> <market_value>
set -euo pipefail
d="$(cd "$(dirname "$0")" && pwd)"
f="$d/snapshots/observations.csv"
[ -f "$f" ] || echo "ts_utc,tier,source,symbol,name,price,change_ratio,volume,market_value" > "$f"
printf '%s,%s,%s,%s,"%s",%s,%s,%s,%s\n' \
  "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" >> "$f"
