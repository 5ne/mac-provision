# Ask user if they want to install Node.js
read -p "Do you want to install Node.js? (y/N) " install_node
install_node=${install_node:-n}

if [[ ! $install_node =~ ^[Yy]$ ]]; then
    echo "Skipping Node.js installation..."
    exit 0
fi

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

