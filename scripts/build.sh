#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
output="$root/build"

rm -rf "$output"
mkdir -p "$output"
cp -R "$root/src/static/." "$output/"

pandoc -s -f markdown+link_attributes -t html5 \
  --output="$output/index.html" \
  --metadata title="Mau Foronda" \
  --template="$root/src/template.html" \
  --lua-filter="$root/src/tweaks.lua" \
  "$root/src/index.md"

echo "Vista creada en $output/index.html"
