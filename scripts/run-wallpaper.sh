#!/bin/zsh
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
runner_bin="$repo_root/build/WallpaperRunner/PolyhedraWallpaper"

if [[ ! -x "$runner_bin" ]]; then
  "$repo_root/scripts/build-wallpaper-runner.sh"
fi

saver_path="$HOME/Library/Screen Savers/Polyhedra.saver"
if [[ ! -d "$saver_path" ]]; then
  saver_path="$repo_root/build/Release/Polyhedra.saver"
fi

if [[ ! -d "$saver_path" ]]; then
  echo "error: saver bundle not found. Run scripts/install-saver.sh first." >&2
  exit 1
fi

exec "$runner_bin" "$saver_path"
