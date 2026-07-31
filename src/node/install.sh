#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
node_version="${NODEVERSION:-lts}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

# Check option compatibility.
case "${node_version}" in 20 | 24 | 26) ;; lts) node_version=24 ;; latest) node_version=26 ;; *) error "NODEVERSION must be 20, 24, 26, lts, or latest." ;; esac

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
require_command apt-get
require_command curl
require_command dpkg-query
require_command gpg

require_apt_package() {
    local package_status
    package_status="$(dpkg-query -W -f='${db:Status-Abbrev}' "$1" 2>/dev/null)" || error "Required apt package not found: $1"
    [[ "${package_status}" == "ii " ]] || error "Required apt package not found: $1"
}
require_apt_package ca-certificates
require_apt_package curl
require_apt_package gnupg

# Installation

# Install functions.
install_apt_packages() {
    apt-get update
    apt-get install -y --no-install-recommends "$@"
    apt-get clean
    rm -rf /var/lib/apt/lists/*
}

# Install packages.
# 1. Node.js
export DEBIAN_FRONTEND=noninteractive
log "Installing Node.js ${node_version}."
curl -fsSL "https://deb.nodesource.com/setup_${node_version}.x" | bash -
install_apt_packages nodejs
