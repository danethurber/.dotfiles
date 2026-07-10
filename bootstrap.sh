#!/usr/bin/env bash
# Single entry point for provisioning a machine from these dotfiles.
# Idempotent — safe to re-run. See SETUP.md for the manual (GUI/auth) steps.
set -euo pipefail

DOTFILES="$HOME/.dotfiles"
VSCODE_USER="$HOME/Library/Application Support/Code/User"

echo "==> Bootstrapping dotfiles..."

# ----- Homebrew -----
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ----- Packages -----
echo "==> Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"

# ----- Directories -----
echo "==> Creating directories..."
mkdir -p ~/.config ~/.config/mise ~/.config/ghostty ~/.config/ccstatusline
mkdir -p ~/Projects ~/.claude "$VSCODE_USER"

# ----- Symlinks -----
echo "==> Creating symlinks..."
# ~/.zshrc is a plain file (NOT a symlink) that just sources the tracked config.
# Some tools (e.g. corporate endpoint-security agents) like to append directly
# to ~/.zshrc; a thin wrapper means their edits land here, never in the repo.
cat > ~/.zshrc <<'EOF'
# Do not edit directly — this just sources the tracked config.
source ~/.dotfiles/zsh/.zshrc
EOF
ln -sfn "$DOTFILES/nvim"                  ~/.config/nvim
ln -sfn "$DOTFILES/mise/config.toml"      ~/.config/mise/config.toml
ln -sfn "$DOTFILES/ghostty/config"        ~/.config/ghostty/config
ln -sfn "$DOTFILES/ccstatusline/settings.json" ~/.config/ccstatusline/settings.json
ln -sfn "$DOTFILES/.gitconfig"            ~/.gitconfig.local
ln -sfn "$DOTFILES/.editorconfig"         ~/.editorconfig
ln -sfn "$DOTFILES/claude/CLAUDE.md"      ~/.claude/CLAUDE.md
# claude/settings.json is gitignored (it absorbs Claude Code's runtime writes), so it
# won't exist on a fresh clone. Seed it from the committed template before symlinking.
[ -f "$DOTFILES/claude/settings.json" ] || cp "$DOTFILES/claude/settings.example.json" "$DOTFILES/claude/settings.json"
ln -sfn "$DOTFILES/claude/settings.json"  ~/.claude/settings.json
ln -sfn "$DOTFILES/vscode/settings.json"     "$VSCODE_USER/settings.json"
ln -sfn "$DOTFILES/vscode/keybindings.json"  "$VSCODE_USER/keybindings.json"
ln -sfn "$DOTFILES/caddy/Caddyfile"        "$(brew --prefix)/etc/Caddyfile"

# ----- Caddy (local *.lvh.me reverse proxy) -----
echo "==> Starting caddy (background service, auto-starts at login)..."
brew services start caddy >/dev/null 2>&1 || brew services restart caddy

# ----- Git config -----
echo "==> Configuring git..."
git config --global include.path "~/.gitconfig.local"
git config --global user.name "Dane Thurber"
git config --global user.email "dane.thurber@gmail.com"
# NOTE: user.signingkey (1Password SSH public key) is set manually — see SETUP.md.

# ----- Runtimes -----
echo "==> Installing runtimes via mise (Node + Go + Python)..."
# mise won't read a config at a new path until it's trusted (security feature).
mise trust "$DOTFILES/mise/config.toml" >/dev/null 2>&1 || true
mise install

# ----- VSCode extensions -----
# Prefer `code` on PATH; fall back to the app bundle (fresh installs don't add it to PATH).
CODE_BIN="$(command -v code || true)"
[ -z "$CODE_BIN" ] && [ -x "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ] \
  && CODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
if [ -n "$CODE_BIN" ]; then
  echo "==> Installing VSCode extensions..."
  grep -vE '^\s*#|^\s*$' "$DOTFILES/vscode/extensions.txt" | while read -r ext; do
    "$CODE_BIN" --install-extension "$ext" --force || echo "    warn: failed to install $ext"
  done
else
  echo "==> VSCode not found; skipping extensions (install VSCode, then re-run bootstrap)."
fi

# ----- Neovim plugin sync (headless, no interactive first launch) -----
if command -v nvim &>/dev/null; then
  echo "==> Syncing Neovim plugins (LazyVim/Mason)..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || echo "    (nvim sync had warnings — open nvim to finish)"
fi

# ----- Antidote (static plugin bundle for fast shell startup) -----
echo "==> Regenerating antidote plugins..."
zsh -c 'source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh && antidote bundle < ~/.dotfiles/zsh/.zsh_plugins.txt > ~/.dotfiles/zsh/.zsh_plugins.zsh'

# ----- Signing sanity check -----
if ! git config --global --get user.signingkey >/dev/null 2>&1; then
  echo ""
  echo "!!  WARNING: commit signing is ON but git user.signingkey is not set."
  echo "    Commits will FAIL until you set it (SETUP.md → 1Password):"
  echo "      git config --global user.signingkey \"ssh-ed25519 AAAA...\""
fi

echo ""
echo "==> Done! Next steps (manual) are in SETUP.md:"
echo "    - 1Password: enable SSH agent + Git commit signing, set user.signingkey"
echo "    - gh auth login"
echo "    - Create ~/.env for secrets"
echo "    - Optional: ./macos.sh for system defaults"
echo "    Open a new Ghostty window to load the new shell."
