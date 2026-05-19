#!/usr/bin/env bash
# install.sh — copy rules/ into ~/.claude/rules/investment/
#
# Usage:
#   ./install.sh            # install everything (common + kr-equity + quant-bot)
#   ./install.sh common     # install only common (the ten commandments)
#   ./install.sh kr-equity  # install only Korean-equity overlay
#   ./install.sh quant-bot  # install only quant-bot enforcement overlay
#
# Idempotent. Overwrites existing files.

set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/rules"
DEST_DIR="${INVESTMENT_RULES_DEST:-$HOME/.claude/rules/investment}"

install_dir() {
  local name="$1"
  local from="$SRC_DIR/$name"
  local to="$DEST_DIR/$name"

  if [[ ! -d "$from" ]]; then
    echo "skip: $name (source missing)"
    return
  fi

  mkdir -p "$to"
  cp -R "$from"/* "$to"/
  echo "installed: $name -> $to"
}

mkdir -p "$DEST_DIR"

if [[ $# -eq 0 ]]; then
  install_dir common
  install_dir kr-equity
  install_dir quant-bot
else
  for arg in "$@"; do
    install_dir "$arg"
  done
fi

echo
echo "Done. Reference these in your CLAUDE.md / AGENTS.md:"
echo "  @$DEST_DIR/common/00-index.md"
