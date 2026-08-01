#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
# shellcheck source=/dev/null
source dev-container-features-test-lib

# Tests

# Verify pipx is installed in its dedicated virtual environment and exposed globally.
check "pipx is installed" pipx --version
check "pipx virtual environment exists" test -x /usr/local/lib/pipx/bin/pipx
check "pipx symlink exists" test -L /usr/local/bin/pipx
# shellcheck disable=SC2016 # Expand expressions in the child shell.
check "pipx symlink has the expected target" bash -c '[[ "$(readlink /usr/local/bin/pipx)" == "/usr/local/lib/pipx/bin/pipx" ]]'

reportResults
