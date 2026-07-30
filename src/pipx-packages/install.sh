#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
pipx_cooldown="${PIPXCOOLDOWN-7}"
package_list=()
if [[ -n "${PIPXPACKAGES:-}" ]]; then
    read -r -a package_list <<<"${PIPXPACKAGES}"
fi

# Logging functions.
log() { printf '%s\n' "$*"; }
error() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

# Check option compatibility.
# No option compatibility checks are required.

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
require_command pipx

# Installation

# Install functions.
# No install functions are required.

# Install packages.
if [[ ${#package_list[@]} -gt 0 ]]; then
    pipx_install_args=(--global)
    if [[ -n "${pipx_cooldown}" ]]; then
        pipx_install_args+=(--cooldown="${pipx_cooldown}")
    fi

    log "Installing global pipx packages."
    for package in "${package_list[@]}"; do
        pipx install "${pipx_install_args[@]}" "${package}"
    done
fi
