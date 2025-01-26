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

# Configure Git with email if not already set
if [ -z "$(git config --global user.email)" ]; then
    echo "Configuring Git..."
    read -p "Please enter your Git email address: " git_email
    git config --global user.email "$git_email"

    echo "Setting up Git aliases..."
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.st status
    git config --global alias.unstage 'reset HEAD --'
    git config --global alias.last 'log -1 HEAD'
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    echo "Git aliases configured"
else
    echo "Git email is already configured"
fi

# Install GitHub CLI if not already installed
if ! command -v gh &> /dev/null; then
    echo "Installing GitHub CLI..."
    brew install gh
else
    echo "GitHub CLI is already installed"
fi

echo "Git and GitHub CLI installation and configuration complete!"

# Check if nvm is installed
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash
    
    # Add nvm to shell config if not already present
    if ! grep -q "export NVM_DIR=\"\$HOME/.nvm\"" "$HOME/.zprofile"; then
        echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.zprofile"
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$HOME/.zprofile"
    fi
    
    # Source nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    echo "nvm installed successfully"
else
    echo "nvm is already installed"
fi

# Install latest Node.js version if not already installed
if ! command -v node &> /dev/null; then
    echo "Installing latest Node.js version..."
    nvm install node # Installs latest version
    nvm use node # Uses latest version
    echo "Node.js installed successfully"
else
    echo "Node.js is already installed"
fi

