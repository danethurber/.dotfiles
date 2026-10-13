"""For each .scratch note, list the Jira keys and PR numbers it names, with their current state.

Usage: evidence.py <bundle> [jira.tsv]
PR states come from `gh pr list` in the repo that holds the bundle.
jira.tsv is `KEY<TAB>Status` per line. Without it, the script prints the keys to look up and exits.
"""
import json
import os
import re
import subprocess
import sys

sys.path.insert(0, os.path.dirname(__file__))
from lib import notes

KEY = re.compile(r'\b(?:CL|PA|IS|DDU)-\d+\b')
PR = re.compile(r'(?:pull/|PR #?|PRs? |#)(\d{3,5})\b')
PLACEHOLDERS = {'CL-000', 'CL-123'}


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    bundle = os.path.abspath(sys.argv[1])
    found = {}
    for path in notes(bundle):
        text = open(os.path.join(bundle, path)).read()
        found[path] = (sorted(set(KEY.findall(text)) - PLACEHOLDERS), sorted(set(PR.findall(text)), key=int))
    keys = sorted({k for ks, _ in found.values() for k in ks})
    if len(sys.argv) < 3:
        print('Look these up in Jira, then rerun with a KEY<TAB>Status file:')
        print('key in (' + ','.join(keys) + ')')
        return
    jira = dict(line.rstrip('\n').split('\t') for line in open(sys.argv[2]) if '\t' in line)
    out = subprocess.run(['gh', 'pr', 'list', '--state', 'all', '--limit', '2000', '--json', 'number,state'],
                         cwd=os.path.dirname(bundle), capture_output=True, text=True, check=True).stdout
    prs = {str(p['number']): p['state'] for p in json.loads(out)}
    for path, (ks, ns) in found.items():
        j = ', '.join(f'{k}={jira.get(k, "?")}' for k in ks)
        p = ', '.join(f'#{n}={prs.get(n, "?")}' for n in ns)
        print(f'{path} | jira: {j} | prs: {p}')


if __name__ == '__main__':
    main()
