#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
# shellcheck source=/dev/null
source dev-container-features-test-lib

# Tests

# Verify the feature adds the user to each requested group.
# shellcheck disable=SC2016 # Expand expressions in the child shell.
check "Default user belongs to the root group" bash -c '[[ " $(id -Gn dev) " == *" root "* ]]'
# shellcheck disable=SC2016 # Expand expressions in the child shell.
check "Default user belongs to the daemon group" bash -c '[[ " $(id -Gn dev) " == *" daemon "* ]]'

reportResults
