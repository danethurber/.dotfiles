# Project: <name>

> Drop this into a repo as `CLAUDE.md` and keep only the stack section(s) you need.
> The global protocol at `~/.claude/CLAUDE.md` still applies; this adds project conventions.

## Python (uv + ruff)
- **uv** owns the env: `uv sync`, `uv add [--dev] <pkg>`, `uv run <cmd>`. Never call `pip`.
- **ruff** lint+format: `uv run ruff check --fix . && uv run ruff format .`. **ty** (or pyright) for types.
- Interpreter from **mise** (`.python-version`). Add deps via `uv add`, not by editing `pyproject.toml`.
- Test: `uv run pytest`.

## Go
- Go version from **mise** (`mise.toml` / `.go-version`). gopls + goimports + golangci-lint + delve.
- Build `go build ./...` · Test `go test -race ./...` · Lint `golangci-lint run` · Format `goimports -w .` · `go mod tidy`.
- Format with goimports (groups imports). Table-driven tests with `t.Run`. Wrap errors: `fmt.Errorf("...: %w", err)`.

## TypeScript / Node
- **Node** from **mise** (`.nvmrc`). **pnpm** is the package manager (pinned via `packageManager` + corepack).
- **ESLint** (flat config) + **Prettier**. Framework: <Vue/Nuxt | React/Next>.
- Install `pnpm install` · Dev `pnpm dev` · Build `pnpm build` · Test `pnpm test` · Lint `pnpm lint`.
- pnpm only (no npm/yarn lockfiles). TS strict; avoid `any`. Named exports. Respect repo ESLint/Prettier config.
