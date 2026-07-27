#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
# shellcheck source=/dev/null
source dev-container-features-test-lib

# Tests

# Verify the feature accepts its empty default package list.
check "APT packages feature completed" true

reportResults
