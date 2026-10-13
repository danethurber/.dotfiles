"""Move .scratch notes to new paths, set the frontmatter for the new home, unwrap, and relink.

Usage: move.py <bundle> <moves.tsv> [--force]
moves.tsv: one `old/path.md<TAB>new/path.md` per line, both relative to the bundle.
A note written in the last 60 minutes is skipped unless --force, since another session may own it.
"""
import os
import re
import sys
import time

sys.path.insert(0, os.path.dirname(__file__))
from lib import FOLDER_KIND, HOMES, anchor_date, link_pattern, notes, set_field, split, stale_after, touch, unwrap


def main():
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    bundle, plan = sys.argv[1], os.path.abspath(sys.argv[2])
    force = '--force' in sys.argv
    os.chdir(bundle)
    moves = [line.rstrip('\n').split('\t') for line in open(plan) if line.strip()]
    done = []
    for src, dst in moves:
        if not os.path.exists(src):
            print(f'SKIP missing {src}')
            continue
        if os.path.exists(dst):
            print(f'SKIP target exists {dst}')
            continue
        if not force and time.time() - os.path.getmtime(src) < 3600:
            print(f'SKIP written in the last hour, another session may own it: {src}')
            continue
        fm, body = split(open(src).read())
        folder = os.path.dirname(dst)
        _, typ, status, window = HOMES[FOLDER_KIND[folder]]
        fm = set_field(fm, 'type', typ)
        fm = set_field(fm, 'status', status)
        fm = set_field(fm, 'stale_after', stale_after(anchor_date(src, fm), window))
        fm = touch(fm)
        os.makedirs(folder or '.', exist_ok=True)
        open(dst, 'w').write(f'---\n{fm}---\n{unwrap(body)}')
        os.remove(src)
        done.append((src, dst))
        print(f'moved {src} -> {dst}')
    for path in notes('.'):
        text = original = open(path).read()
        for src, dst in done:
            text = link_pattern(src).sub('/' + dst, text)
        if text != original:
            open(path, 'w').write(text)
            print(f'relinked {path}')


if __name__ == '__main__':
    main()
