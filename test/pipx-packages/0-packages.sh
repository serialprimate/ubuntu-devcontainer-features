#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
# shellcheck source=/dev/null
source dev-container-features-test-lib

# Tests

# Verify pipx is available without installing any global packages.
check "pipx is installed" pipx --version

reportResults
