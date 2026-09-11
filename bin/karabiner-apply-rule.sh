#!/usr/bin/env bash
# Seed/merge the tracked Karabiner complex_modifications into the machine-owned
# ~/.config/karabiner/karabiner.json, which Karabiner Elements rewrites when
# devices connect/disconnect. Only meaningful on macOS.
#
# On a fresh install this creates karabiner.json from karabiner.seed.json
# (Karabiner adopts it on first launch). On an existing install it merges in
# only the complex_modifications rules that are missing, leaving every other
# key Karabiner owns untouched. Safe to re-run.

set -euo pipefail

[ "$(uname -s)" = "Darwin" ] || exit 0

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
SEED="$REPO_ROOT/.config/karabiner/karabiner.seed.json"
KDIR="$HOME/.config/karabiner"
KFILE="$KDIR/karabiner.json"
DESC='Change caps_lock to command+control+option+shift.'

if [ ! -f "$SEED" ]; then
  echo "karabiner: seed not found at $SEED; skipping"
  exit 0
fi

# Convert a legacy whole-dir/file symlink (old dotfiles managed this dir) to a
# real directory so Karabiner's rewrites stop touching the git checkout.
if [ -L "$KDIR" ]; then
  echo "karabiner: replacing symlinked config dir with a real one"
  SRC_TARGET="$(readlink "$KDIR")"
  rm "$KDIR"
  mkdir -p "$KDIR"
  [ -d "$SRC_TARGET" ] && cp -a "$SRC_TARGET/." "$KDIR/" 2>/dev/null || true
fi
if [ -L "$KFILE" ]; then
  echo "karabiner: replacing symlinked karabiner.json with a real file"
  rm -f "$KFILE"
fi

mkdir -p "$KDIR"

if [ ! -f "$KFILE" ]; then
  echo "karabiner: seeding $KFILE"
  cp "$SEED" "$KFILE"
  exit 0
fi

RULES="$(jq -c '[.profiles[] | select(.selected == true)][0].complex_modifications.rules // []' "$SEED")"

if jq -e --arg desc "$DESC" \
  '.profiles[] | select(.selected == true)
     | [ .complex_modifications.rules[]? | .manipulators[]? | .description ]
     | index($desc)' "$KFILE" >/dev/null 2>&1; then
  echo "karabiner: $DESC already present; nothing to do"
  exit 0
fi

echo "karabiner: adding $DESC"
jq --argjson rules "$RULES" --arg desc "$DESC" '
  .profiles |= map(
    if .selected then
      .complex_modifications //= {} |
      (.complex_modifications.rules // []) as $r |
      if (any($r[]?; any(.manipulators[]?; .description == $desc))) then .
      else .complex_modifications.rules = ($r + $rules)
      end
    else . end
  )' "$KFILE" > "$KFILE.tmp" && mv "$KFILE.tmp" "$KFILE"

echo "karabiner: $KFILE updated"