#!/usr/bin/env bash
set -euo pipefail

# Inputs
# No test inputs are required.

# Prerequisites
# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests
# Verify every selected Python tool is installed.
check "Python 3.14 is installed" bash -c 'python3.14 --version | grep -E "^Python 3\.14\."'
check "pipx is installed" pipx --version
check "Ruff is installed" ruff --version
check "Pyright is installed" pyright --version

reportResults