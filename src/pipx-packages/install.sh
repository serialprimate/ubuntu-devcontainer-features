#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
min_release_age="${MINRELEASEAGE:-7}"
package_list=()
if [ -n "${PIPXPACKAGES:-}" ]; then
    IFS=',' read -r -a requested_packages <<< "${PIPXPACKAGES}"
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
require_command pipx
require_command python3

# Installation

# Install functions.
initialize_pipx_shared_environment() {
    if [ ! -x /opt/pipx/shared/bin/python ]; then
        python3 -m venv /opt/pipx/shared
    fi
    /opt/pipx/shared/bin/python -m pip install --upgrade pip
}

# Install packages.
if [ ${#package_list[@]} -gt 0 ]; then
    log "Installing global pipx packages."
    initialize_pipx_shared_environment
    for package in "${package_list[@]}"; do
        pipx install --global --pip-args="--uploaded-prior-to=P${min_release_age}D" "${package}"
    done
fi
