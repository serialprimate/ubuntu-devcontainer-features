#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
version="${VERSION:-24}"
install_corepack="${INSTALLCOREPACK:-true}"
min_release_age="${MINRELEASEAGE:-7}"
global_packages=()
if [ -n "${NPMGLOBALPACKAGES:-}" ]; then
    IFS=',' read -r -a requested_packages <<< "${NPMGLOBALPACKAGES}"
    for package in "${requested_packages[@]}"; do
        package="${package#"${package%%[![:space:]]*}"}"
        package="${package%"${package##*[![:space:]]}"}"
        if [ -n "${package}" ]; then
            global_packages+=("${package}")
        fi
    done
fi

# Logging functions.
log() { printf '%s\n' "$*"; }
error() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Check option compatibility.
case "${version}" in 20|24|26) node_version="${version}" ;; lts) node_version=24 ;; latest) node_version=26 ;; *) error "VERSION must be 20, 24, 26, lts, or latest." ;; esac
case "${install_corepack}" in true|false) ;; *) error "INSTALLCOREPACK must be true or false." ;; esac
case "${min_release_age}" in ''|*[!0-9]*) error "MINRELEASEAGE must be a non-negative integer." ;; esac

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
# 1. Node.js repository prerequisites
export DEBIAN_FRONTEND=noninteractive
log "Installing Node.js repository prerequisites."
install_apt_packages ca-certificates curl gnupg

# 2. Node.js
log "Installing Node.js ${node_version}."
curl -fsSL "https://deb.nodesource.com/setup_${node_version}.x" | bash -
install_apt_packages nodejs

# 3. Corepack
if [ "${install_corepack}" = "true" ]; then
    log "Enabling Corepack."
    corepack enable
fi

# 4. Global npm packages
if [ ${#global_packages[@]} -gt 0 ]; then
    log "Installing global npm packages."
    npm install --global --ignore-scripts --min-release-age="${min_release_age}" "${global_packages[@]}"
fi
