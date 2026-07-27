#!/usr/bin/env bash
set -euo pipefail

# Inputs

password_hash='teobtLiiDGEOk'

# Prerequisites

# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests

# Verify sudo remains unconfigured when a password is set but configureSudo is false.
check "Default user has the configured password hash" bash -c '[ "$(getent shadow dev | cut -d: -f2)" = "$1" ]' _ "${password_hash}"
check "Default user has no sudo configuration" bash -c '[ ! -e /etc/sudoers.d/dev ]'

reportResults
