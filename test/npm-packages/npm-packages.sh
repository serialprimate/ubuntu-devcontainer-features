#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests

# Verify the configured global npm package installation.
check "markdownlint-cli2 is installed" markdownlint-cli2 --version

reportResults