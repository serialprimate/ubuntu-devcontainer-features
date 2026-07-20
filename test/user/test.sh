#!/usr/bin/env bash
set -euo pipefail

# Inputs
# No test inputs are required.

# Prerequisites
# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests
# Verify the default development user is created with a locked password.
check "Default user exists" id dev
check "Default user has UID 1000" bash -c '[ "$(id -u dev)" = "1000" ]'
check "Default user has GID 1000" bash -c '[ "$(id -g dev)" = "1000" ]'
check "Default user has Bash shell" bash -c '[ "$(getent passwd dev | cut -d: -f7)" = "/bin/bash" ]'
check "Default user has a locked password" bash -c '[ "$(passwd --status dev | awk "{print \$2}")" = "L" ]'
check "Default user has no sudo access" bash -c '[ ! -e /etc/sudoers.d/dev ]'

reportResults
