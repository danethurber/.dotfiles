#!/usr/bin/env bash
set -uo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
BUNDLE="${1:-.scratch}"
[ -d "$BUNDLE" ] || { echo "No bundle at $BUNDLE"; exit 1; }
ROOT=$(cd "$BUNDLE/.." && pwd)
cd "$BUNDLE" || exit 1
TODAY=$(date +%Y-%m-%d)

fm() { awk '/^---$/{n++; next} n==1' "$1" | grep -m1 "^$2:" \
  | sed "s/^$2:[[:space:]]*//;s/[[:space:]]*#.*//;s/^[\"']//;s/[\"']$//"; }

home_for() { case "$1" in
  Note) echo TOP;; Reference) echo docs;; Research) echo context;;
  ADR) echo adrs;; Plan) echo plans;; "Ticket Draft") echo tickets;;
  Index) echo TOP;; *) echo '?';; esac; }

window_for() { case "$1" in
  Note) echo 30;; Reference) echo 365;; Research) echo 180;;
  Plan) echo 90;; "Ticket Draft") echo 60;; *) echo '';; esac; }

MISPLACED=; VOCAB=; STALE=; WINDOW=; NAMING=; LINKS=

while IFS= read -r f; do
  base=$(basename "$f"); [ "$base" = "__template.md" ] && continue
  d=$(dirname "$f" | sed 's|^\./||;s|^\.$|TOP|')
  raw=$(fm "$f" type); s=$(fm "$f" status); sa=$(fm "$f" stale_after)

  t=$(home_for "$raw" >/dev/null; echo "$raw")
  canon=$(for v in Note Reference Research ADR Plan "Ticket Draft" Index; do
            [ "$(echo "$v" | tr 'A-Z' 'a-z')" = "$(echo "$raw" | tr 'A-Z' 'a-z')" ] && echo "$v"; done)
  [ -n "$canon" ] && t="$canon"
  [ -n "$canon" ] && [ "$canon" != "$raw" ] && VOCAB="${VOCAB}  $d/$base: type '$raw' should be '$canon'\n"
  want=$(home_for "$t")

  if [ "$want" = '?' ]; then
    VOCAB="${VOCAB}  $d/$base: type '$raw' is not in the vocabulary\n"
  elif [ "$d" != "$want" ] && [ "$base" != "index.md" ]; then
    MISPLACED="${MISPLACED}  $d/$base: type '$t' belongs in ${want}/\n"
  fi

  case "$s" in draft|stable|deprecated|'Request for Comments'|'') ;;
    *) VOCAB="${VOCAB}  $d/$base: status '$s' is not in the vocabulary\n";; esac

  if [ -n "$sa" ]; then
    [[ "${sa:0:10}" < "$TODAY" ]] && STALE="${STALE}  $d/$base: stale since ${sa:0:10} (type $t)\n"
    w=$(window_for "$t")
    anchor=$(echo "$base" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2}')
    if [ -n "$w" ] && [ -n "$anchor" ]; then
      exp=$(date -j -v+"${w}"d -f %Y-%m-%d "$anchor" +%Y-%m-%d 2>/dev/null)
      if [ -n "$exp" ]; then
        de=$(date -j -f %Y-%m-%d "$exp" +%s); da=$(date -j -f %Y-%m-%d "${sa:0:10}" +%s 2>/dev/null || echo 0)
        diff=$(( (de - da) / 86400 )); [ $diff -lt 0 ] && diff=$(( -diff ))
        [ $diff -gt 7 ] && WINDOW="${WINDOW}  $d/$base: stale_after ${sa:0:10}, type $t wants +${w}d = $exp\n"
      fi
    fi
  fi

  case "$d" in
    TOP)   [ "$base" = index.md ] || echo "$base" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}-' || NAMING="${NAMING}  $d/$base: top level wants yyyy-mm-dd-slug\n";;
    plans) echo "$base" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}-' || NAMING="${NAMING}  $d/$base: plans/ wants yyyy-mm-dd-slug\n";;
    adrs)  echo "$base" | grep -qE '^[0-9]{3}-'                    || NAMING="${NAMING}  $d/$base: adrs/ wants NNN-slug\n";;
    tickets) echo "$base" | grep -qiE "^([a-z]+-[0-9]+|draft)-" || NAMING="${NAMING}  $d/$base: tickets/ wants draft-slug or KEY-123-slug\n";;
    docs|context) echo "$base" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}-' && NAMING="${NAMING}  $d/$base: $d/ drops the date prefix\n";;
  esac

  while IFS= read -r tgt; do
    [ -z "$tgt" ] && continue
    if [ -e ".${tgt}" ]; then continue
    elif [[ "$tgt" == /.scratch/* ]]; then
      LINKS="${LINKS}  $d/$base -> $tgt: drop the /.scratch prefix\n"
    elif [ -e "${ROOT}${tgt}" ]; then
      LINKS="${LINKS}  $d/$base -> $tgt: repo path, drop the leading slash\n"
    else
      LINKS="${LINKS}  $d/$base -> $tgt: target does not exist\n"
    fi
  done < <(grep -oE '(\]\(|resource: )/[A-Za-z0-9._/-]+\.md' "$f" 2>/dev/null | sed 's/^](//;s/^resource: //' | sort -u)
done < <(find . -name '*.md' | sort)

WRAP=$(find . -name '*.md' -not -path './backups/*' -not -name '__template.md' -print0 | xargs -0 python3 -I "$HERE/unwrap.py" --check 2>/dev/null | sed 's|^\./|  |;s|$|: line breaks inside a paragraph or bullet|' | sed 's|$|\\n|' | tr -d '\n')

section() { [ -n "$2" ] && { printf '\n%s\n' "$1"; printf "$2"; }; }
section "Misplaced (type names a different folder)" "$MISPLACED"
section "Outside the vocabulary" "$VOCAB"
section "Stale (past stale_after)" "$STALE"
section "Wrong stale window for the type" "$WINDOW"
section "Filename convention" "$NAMING"
section "Link form" "$LINKS"
section "Line breaks (run unwrap.py)" "$WRAP"
[ -z "${MISPLACED}${VOCAB}${STALE}${WINDOW}${NAMING}${LINKS}${WRAP}" ] && echo "Clean."
exit 0
