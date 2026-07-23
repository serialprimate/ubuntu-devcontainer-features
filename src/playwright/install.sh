#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
version="${VERSION:-latest}"
browser="${BROWSER:-chromium}"
min_release_age="${MINRELEASEAGE:-7}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Check option compatibility.
case "${browser}" in chromium|firefox|webkit) ;; *) error "BROWSER must be chromium, firefox, or webkit." ;; esac
case "${min_release_age}" in ''|*[!0-9]*) error "MINRELEASEAGE must be a non-negative integer." ;; esac

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
require_command npm
require_command apt-get

# Installation

# Install functions.
# No install functions are required; Playwright manages browser dependencies.

# Install packages.
# 1. Playwright
export PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
log "Installing Playwright ${version}."
npm install --global --ignore-scripts --min-release-age="${min_release_age}" "playwright@${version}"

# 2. Browser dependencies
export DEBIAN_FRONTEND=noninteractive
log "Installing ${browser} dependencies."
npx playwright install-deps "${browser}"
apt-get clean
rm -rf /var/lib/apt/lists/*

# 3. Browser runtime
log "Installing ${browser} browser runtime."
npx playwright install "${browser}"
chmod -R a+rX "${PLAYWRIGHT_BROWSERS_PATH:-/ms-playwright}"
