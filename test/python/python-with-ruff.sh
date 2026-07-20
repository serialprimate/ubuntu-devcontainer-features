#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests

# Verify the selected Python version and Ruff installation.
check "Python 3.14 is installed" bash -c 'python3.14 --version | grep -E "^Python 3\.14\."'
check "Ruff is installed" ruff --version

reportResults
