#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests

# Verify npm is available for global package installation.
check "npm is installed" npm --version

reportResults
