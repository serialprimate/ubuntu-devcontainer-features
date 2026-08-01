#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# Prerequisites

# Load the dev container feature test library.
# shellcheck source=/dev/null
source dev-container-features-test-lib

# Tests

# Verify an unset password results in passwordless sudo access.
# shellcheck disable=SC2016 # Expand expressions in the child shell.
check "Default user has a locked password" bash -c '[[ "$(passwd --status dev | awk "{print \$2}")" == "L" ]]'
# shellcheck disable=SC2016 # Expand expressions in the child shell.
check "Default user has passwordless sudo access" bash -c '[[ "$(cat /etc/sudoers.d/dev)" == "dev ALL=(root) NOPASSWD: ALL" ]]'
check "Default user can use sudo without a password" su --login dev --command='sudo --non-interactive true'
check "Sudo configuration is valid" visudo --check --file=/etc/sudoers.d/dev

reportResults
