import datetime
import os
import re

HOMES = {
    'note': ('', 'Note', 'draft', 30),
    'plan': ('plans', 'Plan', 'draft', 90),
    'ticket': ('tickets', 'Ticket Draft', 'draft', 60),
    'reference': ('docs', 'Reference', 'stable', 365),
    'research': ('context', 'Research', 'stable', 180),
    'adr': ('adrs', 'ADR', "'Request for Comments'", None),
}
FOLDER_KIND = {home[0]: kind for kind, home in HOMES.items()}


def now():
    return datetime.datetime.now().astimezone().replace(microsecond=0).isoformat()


def today():
    return datetime.date.today()


def split(text):
    if not text.startswith('---\n'):
        return None, text
    _, fm, body = text.split('---\n', 2)
    return fm, body


def set_field(fm, key, value):
    if value is None:
        return re.sub(rf'^{key}:.*\n', '', fm, flags=re.M)
    if re.search(rf'^{key}:', fm, re.M):
        return re.sub(rf'^{key}:.*$', f'{key}: {value}', fm, count=1, flags=re.M)
    return fm.rstrip('\n') + f'\n{key}: {value}\n'


def touch(fm):
    return re.sub(r'(generated:\n  by: [^\n]+\n  at: )[^\n]+', rf'\g<1>{now()}', fm, count=1)


def stale_after(anchor, days):
    if days is None:
        return None
    due = max(anchor + datetime.timedelta(days=days), today())
    return due.isoformat() + 'T00:00:00Z'


def anchor_date(path, fm):
    m = re.search(r'(\d{4}-\d{2}-\d{2})', os.path.basename(path))
    if m:
        return datetime.date.fromisoformat(m.group(1))
    m = re.search(r'at: (\d{4}-\d{2}-\d{2})', fm or '')
    return datetime.date.fromisoformat(m.group(1)) if m else today()


def unwrap(body):
    out, fence = [], False
    for line in body.split('\n'):
        if line.lstrip().startswith('```'):
            fence = not fence
            out.append(line)
            continue
        block = fence or re.match(r'\s*(#|- |\||\* |\d+\. |```|>|<)', line)
        prev = out[-1] if out else ''
        if not block and prev.strip() and line.strip() and not prev.lstrip().startswith(('#', '|', '```', '<')):
            out[-1] = prev.rstrip() + ' ' + line.strip()
        else:
            out.append(line)
    return '\n'.join(out)


def link_pattern(target):
    return re.compile(r'(?<=[(\s`])(?:/\.scratch/|\.scratch/|/)' + re.escape(target) + r'(?=[)#\s`]|$)', re.M)


def notes(bundle):
    for root, _, files in os.walk(bundle):
        rel = os.path.relpath(root, bundle)
        if rel.split(os.sep)[0] == 'backups':
            continue
        for f in sorted(files):
            if f.endswith('.md'):
                yield os.path.normpath(os.path.join(rel, f))
