#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests

# Verify both requested packages are installed.
check "tree is installed" tree --version
check "curl is installed" curl --version

reportResults
