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
require_command_minimum_version() {
    local command_name="$1"
    local minimum_version="$2"
    shift 2

    local version_output
    version_output=$("$@" --version) || error "Could not determine ${command_name} version."
    [[ "${version_output}" =~ ([0-9]+(\.[0-9]+)+) ]] || error "Could not parse ${command_name} version: ${version_output}"

    local installed_version="${BASH_REMATCH[1]}"
    local -a installed_parts minimum_parts
    local index installed_part minimum_part
    IFS=. read -r -a installed_parts <<<"${installed_version}"
    IFS=. read -r -a minimum_parts <<<"${minimum_version}"

    for ((index = 0; index < ${#installed_parts[@]} || index < ${#minimum_parts[@]}; index++)); do
        installed_part="${installed_parts[index]:-0}"
        minimum_part="${minimum_parts[index]:-0}"
        if ((10#${installed_part} > 10#${minimum_part})); then
            return
        fi
        if ((10#${installed_part} < 10#${minimum_part})); then
            error "${command_name} ${minimum_version} or newer is required; found ${installed_version}."
        fi
    done
}
require_command pipx
if [[ -n "${pipx_cooldown}" ]]; then
    require_command_minimum_version pipx 1.16.0 pipx
fi

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
