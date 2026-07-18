#!/usr/bin/env bash
set -euo pipefail

# Inputs
# No test inputs are required.

# Prerequisites
# Load the dev container feature test library.
source dev-container-features-test-lib

# Tests
# Verify all default CLI tools are installed.
check "Brave CLI is installed" bx --help
check "Context7 CLI is installed" ctx7 --help
check "Firecrawl CLI is installed" firecrawl --help
check "Tavily CLI is installed" tvly --help

reportResults