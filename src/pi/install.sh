#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
pi_version="${PIVERSION:-latest}"
npm_min_release_age="${NPMMINRELEASEAGE-7}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

# Check option compatibility.
[[ -n "${pi_version}" ]] || error "PIVERSION must not be empty."

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
require_command npm

# Installation

# Install functions.
# No install functions are required.

# Install packages.
# 1. Pi
npm_install_args=(--global --ignore-scripts)
if [[ -n "${npm_min_release_age}" ]]; then
    npm_install_args+=(--min-release-age="${npm_min_release_age}")
fi

log "Installing Pi ${pi_version}."
npm install "${npm_install_args[@]}" "@earendil-works/pi-coding-agent@${pi_version}"
