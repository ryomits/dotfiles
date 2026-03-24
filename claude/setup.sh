#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.claude/rules"

if [ ! -d "$TARGET_DIR" ]; then
  mkdir -p "$TARGET_DIR"
fi

# Symlink all rule files preserving directory structure
find "$SCRIPT_DIR/rules" -name "*.md" | while read -r src; do
  relative="${src#$SCRIPT_DIR/rules/}"
  dest="$TARGET_DIR/$relative"
  dest_dir="$(dirname "$dest")"

  mkdir -p "$dest_dir"

  if [ -L "$dest" ]; then
    rm "$dest"
  fi

  ln -s "$src" "$dest"
  echo "Linked: $dest -> $src"
done
