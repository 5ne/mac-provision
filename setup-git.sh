#!/bin/bash
# Configures git (email + aliases). Installing git/gh itself is handled by `brew bundle`.
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "$(git config --global user.email)" ]; then
  read -p "Git email address: " git_email
  git config --global user.email "$git_email"
  echo "Git email set to $git_email"
else
  echo "Git email already configured ($(git config --global user.email))"
fi

git config --global include.path "$REPO_DIR/dotfiles/gitconfig"
echo "Git aliases linked from dotfiles/gitconfig"
