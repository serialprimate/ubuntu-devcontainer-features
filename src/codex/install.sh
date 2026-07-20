#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
version="${VERSION:-latest}"
min_release_age="${MINRELEASEAGE:-7}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Check option compatibility.
[ -n "${version}" ] || error "VERSION must not be empty."
case "${min_release_age}" in ''|*[!0-9]*) error "MINRELEASEAGE must be a non-negative integer." ;; esac

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
require_command npm

# Installation

# Install functions.
# No install functions are required.

# Install packages.
# 1. Codex
log "Installing Codex ${version}."
npm install --global --ignore-scripts --min-release-age="${min_release_age}" "@openai/codex@${version}"
