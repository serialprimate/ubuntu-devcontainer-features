#!/usr/bin/env bash
set -euo pipefail

# Inputs
# No test inputs are required.

# Prerequisites
# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests
# Verify the default Playwright and Chromium installations.
check "Playwright is installed" playwright --version
check "Chromium browser is installed" bash -c 'find /ms-playwright -maxdepth 1 -type d -name "chromium-*" -print -quit | grep -q .'

reportResults
