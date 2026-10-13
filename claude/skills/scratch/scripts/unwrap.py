"""Join hard-wrapped lines in .scratch notes. Tables, code blocks, headings, lists and frontmatter keep their lines.

Usage: unwrap.py [--check] <file.md>...
--check lists the files that have line breaks inside a paragraph or a bullet, and changes nothing.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(__file__))
from lib import split, unwrap


def main():
    check = '--check' in sys.argv
    files = [a for a in sys.argv[1:] if a != '--check']
    if not files:
        sys.exit(__doc__)
    found = 0
    for path in files:
        fm, body = split(open(path).read())
        new = unwrap(body)
        if new == body:
            continue
        found += 1
        if check:
            print(path)
        else:
            open(path, 'w').write((f'---\n{fm}---\n' if fm is not None else '') + new)
            print(f'unwrapped {path}')
    sys.exit(1 if check and found else 0)


if __name__ == '__main__':
    main()
