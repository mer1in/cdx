#!/bin/bash

# cdx Installer

set -e

# Define the URL of the script
SCRIPT_URL="https://raw.githubusercontent.com/mer1in/cdx/main/cdx.sh"

# Define the location where the script will be installed
INSTALL_PATH="$HOME/.cdx"

# Fetch the script and save it to the install directory
echo "Downloading cdx script..."
curl -fsSL "$SCRIPT_URL" -o "$INSTALL_PATH"

# Add execution permission to the script
chmod +x "$INSTALL_PATH"

# Check if the script is already sourced in ~/.bashrc
if grep -q "$INSTALL_PATH" "$HOME/.bashrc"; then
    # Remove old source line
    cat $HOME/.bashrc > $HOME/.bashrc.bak
    cat $HOME/.bashrc.bak | sed -e "/$INSTALL_PATH/d" > $HOME/.bashrc
fi

# Add new source line
echo "source $INSTALL_PATH" >> "$HOME/.bashrc"
echo "cdx has been successfully installed or upgraded."

# Inform the user about successful installation
echo "To start using cdx, please restart your terminal session or run 'source ~/.bashrc'."

