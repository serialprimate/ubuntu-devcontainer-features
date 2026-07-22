#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests

# Verify both configured global pipx packages are installed.
check "Black is installed" black --version
check "Ruff is installed" ruff --version

reportResults
