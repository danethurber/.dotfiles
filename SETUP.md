# New Laptop Setup

From a blank macOS install to a working dev environment. The goal is **one command**
(`bootstrap.sh`) plus the short manual checklist below for the steps no script can do.

## 1. Prerequisites (manual)

```bash
xcode-select --install            # Command Line Tools (GUI prompt)
```

Then clone and bootstrap:

```bash
git clone https://github.com/danethurber/.dotfiles.git ~/.dotfiles
~/.dotfiles/bootstrap.sh
```

`bootstrap.sh` is idempotent — safe to re-run. It installs Homebrew, runs `brew bundle`
(all CLIs, Ghostty, VSCode, fonts), symlinks every config (seeding `claude/settings.json`
from its template), trusts + runs `mise install` for the runtimes, installs the VSCode
extensions, syncs Neovim plugins headlessly, and regenerates the antidote bundle.

## 2. Manual checklist (can't be scripted)

- [ ] **1Password** (do this **before your first commit** — signing is on, so commits
      fail until `user.signingkey` is set). Install, sign in, then Settings → Developer:
  - [ ] Enable **"Use the SSH agent"**.
  - [ ] Enable **"Use the key for signing Git commits"** for your SSH key.
  - [ ] Copy the SSH **public** key and set it for git signing:
        ```bash
        git config --global user.signingkey "ssh-ed25519 AAAA...your-key"
        ```
        (`.gitconfig` already sets `gpg.format = ssh` and the 1Password signer program.)
  - [ ] Create the allowed-signers file so you can verify your own commits locally:
        ```bash
        mkdir -p ~/.config/git
        echo "dane.thurber@gmail.com $(git config --global user.signingkey)" \
          > ~/.config/git/allowed_signers
        ```
- [ ] **GitHub auth**: `gh auth login` (choose SSH; 1Password agent handles the key).
- [ ] **Secrets**: create `~/.env` with any API tokens (sourced by `.zshrc`; not committed).
- [ ] **Ghostty / VSCode permissions**: launch each once and grant any macOS prompts
      (Accessibility, etc.).
- [ ] **macOS defaults** (optional): `~/.dotfiles/macos.sh` for key-repeat, Finder, and
      screenshot tweaks. Review before running.
- [ ] **Font**: confirm "Hack Nerd Font" is installed (from `brew bundle`); Ghostty/VSCode
      both reference it.
- [ ] **Node / pnpm** (optional): mise installs Node LTS (from `mise/config.toml`, and
      respects per-repo `.nvmrc`); `pnpm` comes from Homebrew. For per-project package-manager
      pinning, run `corepack enable` in a shell with Node active — it then honors the
      `packageManager` field in `package.json`.
- [ ] **Neovim**: open `nvim` once on a real `.go`/`.ts`/`.py` file — Mason auto-installs the
      LSP servers + formatters (gopls, gofumpt, prettier, …) on first use of each filetype.

## 3. Verify

- [ ] New Ghostty window: `which node` / `which go` / `which python` all resolve to **mise**
      shims; `cd` into a repo with `.nvmrc` switches Node.
- [ ] `uv sync` in a Python project creates `.venv` and starship shows it auto-activated.
- [ ] `go version`, `golangci-lint --version`, `dlv version` succeed (all on PATH). In nvim,
      open a `.go` file → gopls attaches and `:ConformInfo` shows gofumpt/goimports.
- [ ] Make a test commit, then `git log --show-signature` shows it signed via SSH/1Password.
- [ ] `claude` launches with the global CLAUDE.md + plugins; ccstatusline renders.

See the per-stack project templates in `claude/templates/` to seed new repos.
