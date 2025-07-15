#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
    # macOS
    PYTHONPATH=$DFOX_PATH python3 $DFOX_PATH/apps/macos/install_or_update_all.py --mode update
elif [[ "$(uname)" == "Linux" ]]; then
    # Linux
    bash install.sh
else
    echo "Unsupported operating system."
    exit 1
fi