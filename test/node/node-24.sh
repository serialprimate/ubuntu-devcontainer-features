#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests

# Verify the selected Node.js version.
check "Node.js 24 is installed" bash -c 'node --version | grep -E "^v24\."'

reportResults