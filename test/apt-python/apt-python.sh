#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
# shellcheck source=/dev/null
source dev-container-features-test-lib

# Tests

# Verify the configured Python tooling installation.
check "python3 package is installed" dpkg-query -W python3
check "Python 3 is installed" bash -c 'python3 --version | grep -E "^Python 3\."'
check "pip is installed" pip3 --version
check "pipx is installed" pipx --version

reportResults
