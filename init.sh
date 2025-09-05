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
    sudo dnf install -y neovim git ripgrep bat wget unzip fontconfig
    sudo dnf groupinstall -y '@development-tools'
}

# Function to install packages on Debian/Ubuntu-based systems
install_ubuntu() {
    echo "    - Debian/Ubuntu-based system detected. Using apt-get."
    sudo apt-get update
    # The 'bat' package on Ubuntu provides the 'batcat' executable needed for the alias.
    sudo apt-get install -y neovim git ripgrep bat wget unzip build-essential fontconfig
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
# Step 2: Download and Install Nerd Font (FiraCode)
# ---
FONT_FILE="$HOME/.local/share/fonts/FiraCodeNerdFont-Regular.ttf"

if [ ! -f "$FONT_FILE" ]; then
    echo "--> Installing FiraCode Nerd Font..."
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
    FONT_DIR="$HOME/.local/share/fonts"
    TEMP_DIR="/tmp/firacode-nerdfont"

    # Create directories
    mkdir -p "$FONT_DIR"
    mkdir -p "$TEMP_DIR"

    # Download and unzip the font
    echo "    - Downloading FiraCode Nerd Font..."
    wget -q --show-progress -O "$TEMP_DIR/FiraCode.zip" "$FONT_URL"
    echo "    - Unzipping font..."
    unzip -o "$TEMP_DIR/FiraCode.zip" -d "$TEMP_DIR/unzipped" > /dev/null
    echo "    - Installing fonts..."
    cp "$TEMP_DIR/unzipped"/*.ttf "$FONT_DIR/"

    # Clean up temporary files
    rm -rf "$TEMP_DIR"

    # Update font cache
    echo "    - Updating font cache..."
    fc-cache -fv > /dev/null

    echo "--> FiraCode Nerd Font installed successfully."
else
    echo "--> FiraCode Nerd Font already installed. Skipping."
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
echo "    IMPORTANT: For icons to display correctly, please set your terminal's font to 'FiraCode Nerd Font'."
echo "    - Please restart your shell or run 'source ~/.bashrc' for changes to take effect."
echo "    - The first time you open nvim, plugins will be installed automatically."
