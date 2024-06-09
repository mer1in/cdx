#!/bin/bash

# cdx Installer

set -e

# Define the URL of the script
SCRIPT_URL="https://raw.githubusercontent.com/mer1in/cdx/main/cdx.sh"

# Define the location where the script will be installed
INSTALL_DIR="$HOME/.cdx"

# Fetch the script and save it to the install directory
echo "Downloading cdx script..."
curl -fsSL "$SCRIPT_URL" -o "$INSTALL_DIR"

# Add execution permission to the script
chmod +x "$INSTALL_DIR"

# Check if the script is already sourced in ~/.bashrc
if grep -q "$INSTALL_DIR" "$HOME/.bashrc"; then
    # Remove old source line
    sed -i "/$INSTALL_DIR/d" "$HOME/.bashrc"
fi

# Add new source line
echo "source $INSTALL_DIR" >> "$HOME/.bashrc"
echo "cdx has been successfully installed or upgraded."

# Inform the user about successful installation
echo "To start using cdx, please restart your terminal session or run 'source ~/.bashrc'."

