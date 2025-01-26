# Ask user if they want to install Git with GitHub CLI
read -p "Do you want to install Git with GitHub CLI? (y/N) " install_gh
install_gh=${install_gh:-n}

if [[ ! $install_gh =~ ^[Yy]$ ]]; then
    echo "Skipping GitHub CLI installation..."
    exit 0
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
    git config --global alias.cm commit
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
