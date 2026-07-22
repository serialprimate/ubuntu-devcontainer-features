#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
min_release_age="${MINRELEASEAGE:-7}"
package_list=()
if [ -n "${NPMPACKAGES:-}" ]; then
    IFS=',' read -r -a requested_packages <<< "${NPMPACKAGES}"
    for package in "${requested_packages[@]}"; do
        package="${package#"${package%%[![:space:]]*}"}"
        package="${package%"${package##*[![:space:]]}"}"
        if [ -n "${package}" ]; then
            package_list+=("${package}")
        fi
    done
fi

# Logging functions.
log() { printf '%s\n' "$*"; }
error() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Check option compatibility.
case "${min_release_age}" in ''|*[!0-9]*) error "MINRELEASEAGE must be a non-negative integer." ;; esac

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
require_command npm

# Installation

# Install functions.
# No install functions are required.

# Install packages.
if [ ${#package_list[@]} -gt 0 ]; then
    log "Installing global npm packages."
    npm install --global --ignore-scripts --min-release-age="${min_release_age}" "${package_list[@]}"
fi
