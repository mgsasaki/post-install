#!/usr/bin/env bash
#
# macOS post-install bootstrap (Apple Silicon).
# Run from a fresh Mac after cloning this repo:
#   ./macos/setup.sh
#
# Idempotent: safe to re-run. Existing dotfiles are backed up before symlinking.
#
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S 2>/dev/null || echo bk)"

echo "==> 1/4 Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # add brew to PATH for Apple Silicon for the rest of this script
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> 2/4 brew bundle — CORE only (CLI, shell, asdf, fonts; NO GUI apps)"
brew bundle --file="$REPO/macos/Brewfile.core" || echo "  ! some formulae failed — review and re-run"
echo "    GUI apps are NOT auto-installed. Install on demand:"
echo "      brew install --cask cursor                       # one app when you need it"
echo "      brew bundle --file=$REPO/macos/Brewfile.apps     # or all of them at once"

echo "==> 3/4 runtime versions via asdf (.tool-versions)"
command -v asdf >/dev/null 2>&1 || echo "  ! asdf not found (brew bundle should have installed it)"
cp "$REPO/.tool-versions" "$HOME/.tool-versions"
# asdf v0.16+ is a single binary; make its shims resolvable for the rest of this script
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# re-add the plugins captured from the old machine
if [ -f "$REPO/macos/asdf-plugins.txt" ]; then
  while read -r p; do [ -n "$p" ] && asdf plugin add "$p" 2>/dev/null; done < "$REPO/macos/asdf-plugins.txt"
fi
( cd "$HOME" && asdf install ) || echo "  ! some installs failed — bump EOL ruby 2.7.1 / \
python 3.9.19 to arm64-friendly versions in ~/.tool-versions, then re-run 'asdf install'"

echo "==> 3.5/4 oh-my-zsh + powerlevel10k (required by .zshrc)"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
fi
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
[ -d "$P10K_DIR" ] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR" || true

echo "==> 4/4 link dotfiles (backups -> $BACKUP)"
link() {  # link <repo-relative-source> <target-in-home>
  local src="$REPO/$1" dst="$HOME/$2"
  [ -e "$src" ] || { echo "  - skip $1 (not in repo)"; return; }
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then mkdir -p "$BACKUP"; mv "$dst" "$BACKUP/"; fi
  ln -sfn "$src" "$dst"
  echo "  + ~/$2 -> $1"
}
link dotfiles/zsh/.zshrc        .zshrc
link dotfiles/zsh/.p10k.zsh     .p10k.zsh
link dotfiles/bash/.bash_aliases .bash_aliases
link dotfiles/git/config        .gitconfig
link .tool-versions             .tool-versions

cat <<'EOF'

==> Base system ready. Manual steps that this script can't do:
  * Per-app settings via cloud sync: IntelliJ Settings Sync, VS Code Settings Sync
    (see APPS_INVENTORY.md in your migration kit).
  * Restore secrets bundle (~/.ssh, ~/.aws, ~/.gnupg, .npmrc) and fix perms:
      chmod 700 ~/.ssh ~/.gnupg && chmod 600 ~/.ssh/* && chmod 644 ~/.ssh/*.pub
  * VPN: open Viscosity, register with your license, import the SEA .ovpn.
  * The work-gitconfig include paths assume ~/work/... — clone repos there.
EOF
