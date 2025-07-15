#!/bin/bash

# Script to create symbolic links from dotfiles
# This script calls the Python symlinks creation script

echo "Creating symbolic links..."

# Check if DFOX_PATH is set, if not set it to default
if [ -z "$DFOX_PATH" ]; then
    export DFOX_PATH="$HOME/.dotfiles"
    echo "DFOX_PATH not set, using default: $DFOX_PATH"
fi

# Check if the dotfiles directory exists
if [ ! -d "$DFOX_PATH" ]; then
    echo "Error: Dotfiles directory not found at $DFOX_PATH" >&2
    exit 1
fi

# Check if Python 3 is available
if ! command -v python3 &>/dev/null; then
    echo "Error: Python 3 is not installed. Python 3 is required to create symbolic links." >&2
    exit 1
fi

# Change to the dotfiles directory
cd "$DFOX_PATH" || {
    echo "Error: Could not change to dotfiles directory" >&2
    exit 1
}

# Run the symlinks creation script
if [ -f "symlinks/create_symlinks.py" ]; then
    python3 symlinks/create_symlinks.py
    echo "Symbolic links creation completed."
else
    echo "Error: create_symlinks.py not found in symlinks directory" >&2
    exit 1
fi
