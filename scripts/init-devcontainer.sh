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


# Generate Protobufs
export PATH="$WORKSPACE_PATH/vendor/protoc-3.20.3-linux-x86_64/bin:$PATH"
make protobuf

# Initialize React
cd "$WORKSPACE_PATH/frontend"
yarn install

# Return to the workspace root
cd "$WORKSPACE_PATH"

# Set up the Python environment
python3 -m venv venv
source venv/bin/activate

# Install Python dependencies
make all-devel


echo "Dev container setup complete."

