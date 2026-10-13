"""Create a .scratch note in the right home, from that home's template.

Usage: new.py <bundle> <kind> <slug> <title>
kind: note | plan | ticket | reference | research | adr
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(__file__))
from lib import HOMES, now, set_field, split, stale_after, today


def target_path(bundle, kind, slug):
    folder = HOMES[kind][0]
    date = today().isoformat()
    if kind in ('note', 'plan'):
        name = f'{date}-{slug}.md'
    elif kind == 'ticket':
        name = slug if re.match(r'^[A-Z]+-\d+-', slug) else f'draft-{slug}'
        name += '.md'
    elif kind == 'adr':
        used = [int(f[:3]) for f in os.listdir(os.path.join(bundle, 'adrs')) if f[:3].isdigit()]
        repo = os.path.join(bundle, '..', 'docs', 'adrs')
        if os.path.isdir(repo):
            used += [int(f[:3]) for f in os.listdir(repo) if f[:3].isdigit()]
        name = f'{max(used, default=0) + 1:03d}-{slug}.md'
    else:
        name = f'{slug}.md'
    return os.path.join(bundle, folder, name)


def main():
    if len(sys.argv) != 5 or sys.argv[2] not in HOMES:
        sys.exit(__doc__)
    bundle, kind, slug, title = sys.argv[1:]
    if not re.match(r'^[a-z0-9]+(-[a-z0-9]+)*$|^[A-Z]+-\d+(-[a-z0-9]+)+$', slug):
        sys.exit(f'slug must be lowercase and hyphenated: {slug}')
    folder, typ, status, window = HOMES[kind]
    template = os.path.join(bundle, folder, '__template.md')
    fm, _ = split(open(template).read())
    fm = re.sub(r'^template: true\n', '', fm, flags=re.M)
    fm = re.sub(r'^stale_after:.*?(?=\n)', 'stale_after: X', fm, flags=re.M)
    fm = set_field(fm, 'type', typ)
    fm = set_field(fm, 'title', title)
    fm = set_field(fm, 'status', status)
    fm = set_field(fm, 'stale_after', stale_after(today(), window))
    fm = re.sub(r'(generated:\n  by: [^\n]+\n  at: )[^\n]+', rf'\g<1>{now()}', fm, count=1)
    path = target_path(bundle, kind, slug)
    if os.path.exists(path):
        sys.exit(f'already exists: {path}')
    open(path, 'w').write(f'---\n{fm}---\n\n# {title}\n\n')
    print(path)


if __name__ == '__main__':
    main()
