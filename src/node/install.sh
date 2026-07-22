#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
version="${VERSION:-lts}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Check option compatibility.
case "${version}" in 20|24|26) node_version="${version}" ;; lts) node_version=24 ;; latest) node_version=26 ;; *) error "VERSION must be 20, 24, 26, lts, or latest." ;; esac

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
