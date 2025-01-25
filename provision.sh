#!/bin/bash
# Check if Homebrew path is in .zprofile
if ! grep -q "export PATH=\"/opt/homebrew/bin:\$PATH\"" "$HOME/.zprofile"; then
    echo "Adding Homebrew to .zprofile..."
    echo 'export PATH="/opt/homebrew/bin:$PATH"' >> "$HOME/.zprofile"
else
    echo "Homebrew already in .zprofile"
fi

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add Homebrew to PATH if not already present
if [[ ":$PATH:" != *":/opt/homebrew/bin:"* ]]; then
    echo "Adding Homebrew to PATH..."
    export PATH="/opt/homebrew/bin:$PATH"
fi

# Install Git if not already installed 
if ! command -v git &> /dev/null; then
    echo "Installing Git..."
    brew install git
else
    echo "Git is already installed"
fi

# Install GitHub CLI if not already installed
if ! command -v gh &> /dev/null; then
    echo "Installing GitHub CLI..."
    brew install gh
else
    echo "GitHub CLI is already installed"
fi

# Configure Git with email if not already set
if [ -z "$(git config --global user.email)" ]; then
    echo "Configuring Git..."
    read -p "Please enter your Git email address: " git_email
    git config --global user.email "$git_email"
else
    echo "Git email is already configured"
fi

echo "Git and GitHub CLI installation and configuration complete!"
