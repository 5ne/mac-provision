# Git Setup Script

This script automates the process of setting up Git on macOS systems. It performs the following tasks:

1. Checks if Homebrew path is in .zprofile and adds it if missing
2. Installs Homebrew if not already installed
3. Adds Homebrew to PATH if not already present 
4. Installs Git via Homebrew if not already installed
5. Configures Git with user's email address if not already set

## Usage

To run the script:

```bash
./provision.sh
```

The script will prompt you for your Git email address and configure Git accordingly.
