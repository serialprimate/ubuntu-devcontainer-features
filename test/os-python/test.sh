#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests

# Verify the default Python tooling installation.
check "Python 3.14 is installed" bash -c 'python3.14 --version | grep -E "^Python 3\.14\."'
check "pip is installed" pip3 --version
check "pipx is installed" pipx --version

reportResults