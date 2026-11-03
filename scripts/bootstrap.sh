#!/bin/bash
set -euo pipefail

# --migrate backs up and replaces files that differ from the initial snapshot.
# --files-only skips packages, tools and the background service (for CI).
migrate=false
files_only=false
for arg in "$@"; do
  case "$arg" in
    --migrate) migrate=true ;;
    --files-only) files_only=true ;;
    *) echo "Unknown argument: $arg" >&2; exit 1 ;;
  esac
done
repo=$(cd "$(dirname "$0")/.." && pwd)
backup="$HOME/.local/state/birdots/backups/$(date +%Y%m%d-%H%M%S)"
command -v mise >/dev/null || { echo 'Install mise with: brew install mise' >&2; exit 1; }

# Check every conflict before changing anything.
while IFS= read -r -d '' src; do
  rel=${src#"$repo/home/"}
  dst="$HOME/$rel"
  if [[ -e "$dst" || -L "$dst" ]]; then
    if ! cmp -s "$src" "$dst" && ! $migrate; then
      echo "Existing file differs: $dst (use --migrate to back up and replace)" >&2
      exit 1
    fi
  fi
done < <(find "$repo/home" -type f -print0)
while IFS= read -r -d '' src; do
  rel=${src#"$repo/home/"}
  dst="$HOME/$rel"
  if [[ -e "$dst" || -L "$dst" ]]; then
    cmp -s "$src" "$dst" && continue
    mkdir -p "$backup/$(dirname "$rel")"
    cp -p "$dst" "$backup/$rel"
  fi
  mkdir -p "$(dirname "$dst")"
  cp -p "$src" "$dst"
done < <(find "$repo/home" -type f -print0)
# Preserve the private permissions previously supplied by chezmoi.
chmod 600 "$HOME/.config/zed/settings.json"
mise dot save
if ! $files_only; then
  brew bundle --file="$HOME/.homebrew/Brewfile"
  mise install
  mise bootstrap services apply
fi
mise dot status
[[ ! -d "$backup" ]] || echo "Backup: $backup"
