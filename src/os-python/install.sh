#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
python_version="${VERSION:-3.14}"
install_pip="${INSTALLPIP:-true}"
install_pipx="${INSTALLPIPX:-true}"
install_venv="${INSTALLVENV:-true}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Check option compatibility.
for option in "${install_pip}" "${install_pipx}" "${install_venv}"; do
    case "${option}" in
        true|false) ;;
        *) error "Boolean options must be true or false." ;;
    esac
done

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
require_command apt-get

# Installation

# Install functions.
install_apt_packages() {
    apt-get update
    apt-get install -y --no-install-recommends "$@"
    apt-get clean
    rm -rf /var/lib/apt/lists/*
}

# Install packages.
packages=("python${python_version}")
if [ "${install_pip}" = "true" ]; then
    packages+=(python3-pip)
fi
if [ "${install_pipx}" = "true" ]; then
    packages+=(pipx)
fi
if [ "${install_venv}" = "true" ]; then
    packages+=("python${python_version}-venv")
fi

export DEBIAN_FRONTEND=noninteractive
log "Installing Python ${python_version}."
install_apt_packages "${packages[@]}"