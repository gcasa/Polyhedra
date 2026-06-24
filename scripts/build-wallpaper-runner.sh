#!/bin/zsh
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
out_dir="$repo_root/build/WallpaperRunner"
out_bin="$out_dir/PolyhedraWallpaper"

mkdir -p "$out_dir"

runner_src="$repo_root/WallpaperRunner/main.m"

clang \
  "$runner_src" \
  -fobjc-arc \
  -framework AppKit \
  -framework ScreenSaver \
  -O2 \
  -o "$out_bin"

echo "Built wallpaper runner: $out_bin"
