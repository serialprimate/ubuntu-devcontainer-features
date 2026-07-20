#!/usr/bin/env bash
set -euo pipefail

# Inputs
# No test inputs are required.

# Prerequisites
# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests
# Verify the selected CLI tool is installed.
check "Context7 CLI is installed" ctx7 --help

reportResults
