#!/usr/bin/env bash
set -euo pipefail

# Inputs
# No test inputs are required.

# Prerequisites
# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests
# Verify Node.js, Corepack, and the selected global package are installed.
check "Node.js 24 is installed" bash -c 'node --version | grep -E "^v24\."'
check "Corepack is installed" corepack --version
check "markdownlint-cli2 is installed" markdownlint-cli2 --version

reportResults
