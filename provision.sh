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

./install-git.sh
./install-node.sh

echo "Provisioning complete!"