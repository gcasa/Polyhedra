#!/bin/zsh
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

xcodebuild \
  -project "$repo_root/Polyhedra.xcodeproj" \
  -target Polyhedra \
  -configuration Release \
  build

built_saver="$repo_root/build/Release/Polyhedra.saver"
install_dir="$HOME/Library/Screen Savers"

if [[ ! -d "$built_saver" ]]; then
  echo "error: could not find built saver at $built_saver" >&2
  exit 1
fi

mkdir -p "$install_dir"
rm -rf "$install_dir/Polyhedra.saver"
cp -R "$built_saver" "$install_dir/Polyhedra.saver"

echo "Installed: $install_dir/Polyhedra.saver"
