#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if a workspace path is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <workspace-path>"
    exit 1
fi

WORKSPACE_PATH="$1"


cd "$WORKSPACE_PATH"
. $NVM_DIR/nvm.sh
nvm install
nvm use


# Initialize React
yarn install

# Return to the workspace root
cd "$WORKSPACE_PATH"

python3 -m venv venv
source venv/bin/activate

# Upgrade pip and install Python dependencies
pip install --upgrade pip
make python-init


# Install Python dependencies
pip install -r lib/dev-requirements.txt
pip install -r lib/test-requirements.txt

# Generate Protobufs
export PATH="$WORKSPACE_PATH/vendor/protoc-3.20.3-linux-x86_64/bin:$PATH"
make protobuf

echo "Dev container setup complete."
