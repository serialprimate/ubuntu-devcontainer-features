#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
# shellcheck source=/dev/null
source dev-container-features-test-lib

# Tests

# Verify quoting, escaping, dynamic expansion, literal values, and empty arguments.
# shellcheck disable=SC2016 # Expand expressions in the child shell.
check "script arguments are evaluated" bash -c '
    mapfile -t values < /tmp/install-script-feature-args
    [[ "${#values[@]}" -eq 10 ]]
    [[ "${values[0]}" == "--label" ]]
    [[ "${values[1]}" == "two words" ]]
    [[ "${values[2]}" == "--expanded" ]]
    [[ "${values[3]}" == "root" ]]
    [[ "${values[4]}" == "--literal" ]]
    [[ "${values[5]}" == "\$HOME" ]]
    [[ "${values[6]}" == "--escaped" ]]
    [[ "${values[7]}" == "escaped value" ]]
    [[ "${values[8]}" == "--empty" ]]
    [[ -z "${values[9]}" ]]
'

# Verify environment assignments are evaluated and isolated to the target script.
# shellcheck disable=SC2016 # Expand expressions in the child shell.
check "script environment variables are evaluated" bash -c '
    mapfile -t values < /tmp/install-script-feature-env
    [[ "${#values[@]}" -eq 4 ]]
    [[ "${values[0]}" == "hello world" ]]
    [[ "${values[1]}" == "root" ]]
    [[ "${values[2]}" == "\$HOME" ]]
    [[ -z "${values[3]}" ]]
'
# shellcheck disable=SC2016 # Expand expressions in the child shell.
check "script environment variables do not persist" bash -c '[[ -z "${GREETING+x}" ]]'

# Remove files created by the downloaded test fixture.
rm -f /tmp/install-script-feature-args /tmp/install-script-feature-env

reportResults
