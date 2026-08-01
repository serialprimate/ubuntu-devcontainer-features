#!/usr/bin/env bash
set -euo pipefail

# Inputs

password_hash='teobtLiiDGEOk'

# Prerequisites

# Load the dev container feature test library.
# shellcheck source=/dev/null
source dev-container-features-test-lib

# Tests

# Verify a configured password results in password-protected sudo access.
# shellcheck disable=SC2016 # Expand expressions in the child shell.
check "Default user has the configured password hash" bash -c '[[ "$(getent shadow dev | cut -d: -f2)" == "$1" ]]' _ "${password_hash}"
# shellcheck disable=SC2016 # Expand expressions in the child shell.
check "Default user has password-protected sudo access" bash -c '[[ "$(cat /etc/sudoers.d/dev)" == "dev ALL=(root) ALL" ]]'
check "Sudo configuration is valid" visudo --check --file=/etc/sudoers.d/dev

reportResults
