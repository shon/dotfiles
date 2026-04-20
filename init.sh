#!/bin/bash
#
# This script sets up the development environment by installing necessary packages
# and creating symlinks for the configuration files.
#
# This script is designed to be compatible with both Fedora-based (using dnf)
# and Debian/Ubuntu-based (using apt-get) systems.
#

# ---
# Step 1: Install essential packages based on the detected package manager
# ---
echo "--> Detecting package manager and installing essential packages..."

# Function to install packages on Fedora-based systems
install_fedora() {
    echo "    - Fedora/RHEL-based system detected. Using dnf."
    sudo dnf install -y neovim git ripgrep bat curl
    sudo dnf groupinstall -y '@development-tools'
}

# Function to install packages on Debian/Ubuntu-based systems
install_ubuntu() {
    echo "    - Debian/Ubuntu-based system detected. Using apt-get."
    sudo apt-get update
    # The 'bat' package on Ubuntu provides the 'batcat' executable needed for the alias.
    sudo apt-get install -y neovim git ripgrep bat build-essential curl
}

if command -v dnf &> /dev/null; then
    install_fedora
elif command -v apt-get &> /dev/null; then
    install_ubuntu
else
    echo "--> ERROR: Could not find 'dnf' or 'apt-get'. Please install dependencies manually:"
    echo "    - neovim, git, ripgrep, bat (or batcat), wget, unzip, and build tools (gcc, make, etc.)"
    exit 1
fi

echo "--> Essential packages installed."
echo ""


# ---
# Step 2: Install starship prompt
# ---
echo "--> Installing Starship prompt..."
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "    - Starship is already installed."
fi
echo ""

# ---
# Step 3: Create symlinks for configuration files
# ---
echo "--> Creating symlinks for configuration files..."

# Get the directory of the script to create absolute paths
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Bash aliases
echo "    - Symlinking .bash_aliases"
ln -sf "$SCRIPT_DIR/.bash_aliases" "$HOME/.bash_aliases"
# Ensure .bashrc sources the aliases
grep -qF 'source ~/.bash_aliases' ~/.bashrc || echo -e "\nif [ -f ~/.bash_aliases ]; then\n    . ~/.bash_aliases\nfi" >> ~/.bashrc

# Ensure starship is initialized in .bashrc
grep -qF 'starship init bash' ~/.bashrc || echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Git config
echo "    - Symlinking .gitconfig"
ln -sf "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"

# Neovim configuration
echo "    - Symlinking Neovim configuration"
mkdir -p "$HOME/.config"
ln -sf "$SCRIPT_DIR/.config/nvim" "$HOME/.config/nvim"

echo "--> Symlinks created."
echo ""

# ---
# Step 4: Final instructions
# ---
echo "--> Setup complete!"
echo "    - Please restart your shell or run 'source ~/.bashrc' for changes to take effect."
echo "    - The first time you open nvim, plugins will be installed automatically."
