import json
import os
import subprocess
import sys
import time

PROTECTED = ('analytics', 'colada', 'entities')


def git(*args, cwd=None):
    r = subprocess.run(['git', *args], cwd=cwd, capture_output=True, text=True)
    return r.stdout.strip() if r.returncode == 0 else ''


def ok(*args):
    return subprocess.run(['git', *args], capture_output=True).returncode == 0


def pull_requests():
    out = subprocess.run(['gh', 'pr', 'list', '--state', 'all', '--limit', '2000', '--json', 'number,state,headRefName,headRefOid'],
                         capture_output=True, text=True, check=True).stdout
    prs = {}
    for p in json.loads(out):
        prs.setdefault(p['headRefName'], []).append(p)
    return prs


def in_use():
    out = subprocess.run(['lsof', '-a', '-d', 'cwd', '-Fn'], capture_output=True, text=True).stdout
    return {line[1:] for line in out.split('\n') if line.startswith('n')}


def contained(branch, prs):
    tip = git('rev-parse', branch)
    for p in prs:
        if p['state'] != 'MERGED':
            continue
        oid = p['headRefOid']
        if not ok('cat-file', '-e', oid):
            subprocess.run(['git', 'fetch', '-q', 'origin', f'refs/pull/{p["number"]}/head'], capture_output=True)
        if ok('merge-base', '--is-ancestor', tip, oid):
            return True
        r = subprocess.run(['git', 'cherry', oid, branch], capture_output=True, text=True)
        if r.returncode == 0 and not [l for l in r.stdout.split('\n') if l.startswith('+')]:
            return True
    return False


def worktrees():
    items, cur = [], None
    for line in git('worktree', 'list', '--porcelain').split('\n'):
        if line.startswith('worktree '):
            cur = {'path': line[9:], 'branch': None, 'prunable': False}
            items.append(cur)
        elif line.startswith('branch '):
            cur['branch'] = line[7:].replace('refs/heads/', '')
        elif line.startswith('prunable'):
            cur['prunable'] = True
    return items


def verdict_worktree(w, prs, busy, main_path):
    path, branch = w['path'], w['branch']
    if w['prunable'] or not os.path.isdir(path):
        return 'prune', 'folder is gone'
    if path == main_path:
        return 'keep', 'main worktree'
    if any(b == path or b.startswith(path + '/') for b in busy):
        return 'keep', 'a running process uses it'
    dirty = git('status', '--porcelain', cwd=path)
    age = time.time() - int(git('log', '-1', '--format=%ct', cwd=path) or 0)
    if age < 3600:
        return 'keep', 'committed in the last hour'
    if dirty:
        return 'ask', f'{len(dirty.splitlines())} uncommitted changes'
    if not branch:
        head = git('rev-parse', 'HEAD', cwd=path)
        if ok('merge-base', '--is-ancestor', head, 'origin/master'):
            return 'remove', 'detached at a commit on master'
        remote = git('branch', '-r', '--contains', head)
        return ('remove', f'detached, commit is on {remote.split()[0]}') if remote else ('ask', 'detached at a commit only here')
    states = [p['state'] for p in prs.get(branch, [])]
    if 'OPEN' in states:
        return 'keep', 'open PR'
    if 'MERGED' in states and contained(branch, prs[branch]):
        return 'remove', 'PR merged, branch fully in it'
    if any(k in branch for k in PROTECTED):
        return 'keep', 'unmerged analytics or Colada work'
    if 'MERGED' in states:
        return 'ask', 'PR merged, but the branch has commits the PR lacks'
    if 'CLOSED' in states:
        return 'ask', 'PR closed without merging'
    return 'ask', 'no PR'


def main():
    prs = pull_requests()
    busy = in_use()
    items = worktrees()
    main_path = items[0]['path']
    rows = []
    for w in items:
        v, why = verdict_worktree(w, prs, busy, main_path)
        pr = ', '.join(f'#{p["number"]} {p["state"]}' for p in prs.get(w['branch'] or '', []))
        rows.append((v, w['path'], w['branch'] or '(detached)', pr, why))
    order = {'remove': 0, 'prune': 1, 'ask': 2, 'keep': 3}
    print('| Action | Worktree | Branch | PR | Why |\n| --- | --- | --- | --- | --- |')
    for r in sorted(rows, key=lambda r: (order[r[0]], r[1])):
        print('| ' + ' | '.join(r) + ' |')
    if '--branches' not in sys.argv:
        return
    held = {w['branch'] for w in items if w['branch']}
    print('\n| Action | Branch | PR | Why |\n| --- | --- | --- | --- |')
    for b in git('for-each-ref', '--format=%(refname:short)', 'refs/heads').split('\n'):
        if not b or b in ('master', 'main') or b in held:
            continue
        states = [p['state'] for p in prs.get(b, [])]
        pr = ', '.join(f'#{p["number"]} {p["state"]}' for p in prs.get(b, []))
        if 'OPEN' in states:
            v, why = 'keep', 'open PR'
        elif b.startswith('backup/'):
            v, why = 'keep', 'a backup branch'
        elif 'MERGED' in states and contained(b, prs[b]):
            v, why = 'delete', 'PR merged, branch fully in it'
        elif any(k in b for k in PROTECTED):
            v, why = 'keep', 'unmerged analytics or Colada work'
        else:
            v, why = 'ask', 'no merged PR holds every commit'
        print(f'| {v} | {b} | {pr} | {why} |')


if __name__ == '__main__':
    main()
