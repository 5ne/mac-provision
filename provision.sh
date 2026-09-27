#!/bin/bash
# New machine setup. Safe to re-run — every step here is idempotent.
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

# --- Xcode Command Line Tools (needed for git/brew to work at all) ---
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Re-run this script after the Xcode CLT install finishes."
  exit 0
fi

# --- Homebrew ---
if ! grep -q 'export PATH="/opt/homebrew/bin:\$PATH"' "$HOME/.zprofile" 2>/dev/null; then
  echo "Linking shell config..."
  cat "$REPO_DIR/dotfiles/zprofile.append" >> "$HOME/.zprofile"
fi
export PATH="/opt/homebrew/bin:$PATH"

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- Everything declared in the Brewfile ---
echo "Installing packages from Brewfile..."
brew bundle --file="$REPO_DIR/Brewfile"

# --- Git config (email + aliases) ---
./setup-git.sh

# --- macOS system defaults ---
./macos.sh

# --- Node via nvm (optional, interactive) ---
./install-node.sh

echo "Provisioning complete!"
