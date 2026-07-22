#!/usr/bin/env bash
set -euo pipefail

# Inputs

# No test inputs are required.

# This test can be run with the following command from the root of this repository.
# devcontainer features test --global-scenarios-only .

# Prerequisites

# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests

# Verify the combined developer toolchain is installed and usable.
check "Node.js 24 is installed" bash -c 'node --version | grep -E "^v24\."'
check "markdownlint-cli2 is installed" markdownlint-cli2 --version
check "Tree is installed" tree --version
check "Brave CLI is installed" bx --help
check "Context7 CLI is installed" ctx7 --help
check "Firecrawl CLI is installed" firecrawl --help
check "Tavily CLI is installed" tvly --help
check "Codex CLI is installed" codex --version
check "Pi CLI is installed" pi --version
check "Playwright is installed" playwright --version
check "Chromium browser is installed" bash -c 'find /ms-playwright -maxdepth 1 -type d -name "chromium-*" -print -quit | grep -q .'
check "Python 3.14 is installed" bash -c 'python3.14 --version | grep -E "^Python 3\.14\."'
check "pipx is installed" pipx --version
check "Black is installed" black --version
check "Development user is installed" id dev
check "Development user has UID 1000" bash -c '[ "$(id -u dev)" = "1000" ]'
check "Development user has GID 1000" bash -c '[ "$(id -g dev)" = "1000" ]'

reportResults
