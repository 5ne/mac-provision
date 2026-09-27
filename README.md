# mac-provision

Provisions a fresh Mac for my typical stack. Every step is idempotent — safe
to re-run any time (e.g. after adding a line to the Brewfile).

## Usage

```bash
./provision.sh
```

This will, in order:

1. Prompt for Xcode Command Line Tools if missing (re-run the script once that finishes)
2. Install Homebrew, and append `dotfiles/zprofile.append` to `~/.zprofile`
3. Run `brew bundle` against the [`Brewfile`](Brewfile) — CLI tools and casks
4. Run [`setup-git.sh`](setup-git.sh) — sets your git email and links [`dotfiles/gitconfig`](dotfiles/gitconfig) aliases
5. Run [`macos.sh`](macos.sh) — sane macOS defaults (trackpad, Finder, Dock, screenshots)
6. Run [`install-node.sh`](install-node.sh) — optional, prompts before installing nvm + latest Node

## Customizing

- **Want a new CLI tool or app?** Add a `brew "..."` or `cask "..."` line to
  [`Brewfile`](Brewfile) and re-run `brew bundle --file=Brewfile` (or just re-run `./provision.sh`).
- **Want a new git alias or other git config?** Edit [`dotfiles/gitconfig`](dotfiles/gitconfig) directly —
  git reads it live via `include.path`, no script re-run needed.
- **Want different macOS defaults?** Edit [`macos.sh`](macos.sh) and re-run it (`./macos.sh`).
- **Want more dotfiles managed here** (`.zshrc`, editor config, etc.)? Drop them in
  `dotfiles/` and add a symlink step to `provision.sh`.
