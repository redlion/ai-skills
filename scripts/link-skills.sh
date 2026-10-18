#!/usr/bin/env bash
# Symlink every skill outside deprecated/ and misc/ into the local harness
# skill directories. Re-run after adding, removing, or renaming a skill.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
targets=("$HOME/.claude/skills" "$HOME/.agents/skills")

for target in "${targets[@]}"; do
  mkdir -p "$target"

  # Remove links into this repo whose skill no longer exists (renamed or removed).
  for link in "$target"/*; do
    [ -L "$link" ] || continue
    dest="$(readlink "$link")"
    case "$dest" in
      "$repo"/skills/*) [ -e "$dest/SKILL.md" ] || { rm "$link"; echo "removed stale $link"; } ;;
    esac
  done

  while IFS= read -r skill_md; do
    dir="$(dirname "$skill_md")"
    case "$dir" in
      "$repo"/skills/deprecated/* | "$repo"/skills/misc/*) continue ;;
    esac
    name="$(basename "$dir")"
    link="$target/$name"
    if [ -e "$link" ] && [ ! -L "$link" ]; then
      echo "skipped $link: exists and is not a symlink" >&2
      continue
    fi
    ln -sfn "$dir" "$link"
    echo "linked $link"
  done < <(find "$repo/skills" -mindepth 3 -maxdepth 3 -name SKILL.md | sort)
done
