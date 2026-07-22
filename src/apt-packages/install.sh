#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
package_list=()
IFS=',' read -r -a raw_packages <<< "${APTPACKAGES:-}"
for package in "${raw_packages[@]}"; do
    trimmed="${package#"${package%%[![:space:]]*}"}"
    trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"
    if [ -n "${trimmed}" ]; then
        package_list+=("${trimmed}")
    fi
done

# Logging functions.
log() { printf '%s\n' "$*"; }
error() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Check option compatibility.

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
if [ ${#package_list[@]} -gt 0 ]; then
    require_command apt-get
fi

# Installation

# Install functions.
install_apt_packages() {
    apt-get update
    apt-get install -y --no-install-recommends "$@"
    apt-get clean
    rm -rf /var/lib/apt/lists/*
}

# Install packages.
# 1. Requested apt packages
if [ ${#package_list[@]} -gt 0 ]; then
    log "Installing requested apt packages."
    export DEBIAN_FRONTEND=noninteractive
    install_apt_packages "${package_list[@]}"
fi
