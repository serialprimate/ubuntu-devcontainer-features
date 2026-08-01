#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
playwright_version="${PLAYWRIGHTVERSION:-latest}"
browser="${BROWSER:-chromium}"
npm_min_release_age="${NPMMINRELEASEAGE-7}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

# Check option compatibility.
case "${browser}" in chromium | firefox | webkit) ;; *) error "BROWSER must be chromium, firefox, or webkit." ;; esac

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
require_command npm
if [[ -n "${npm_min_release_age}" ]]; then
    require_command_minimum_version npm 11.10.0 npm
fi
require_command apt-get

# Installation

# Install functions.
# No install functions are required; Playwright manages browser dependencies.

# Install packages.
# 1. Playwright
npm_install_args=(--global --ignore-scripts)
if [[ -n "${npm_min_release_age}" ]]; then
    npm_install_args+=(--min-release-age="${npm_min_release_age}")
fi

export PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
log "Installing Playwright ${playwright_version}."
npm install "${npm_install_args[@]}" "playwright@${playwright_version}"

# 2. Browser dependencies
export DEBIAN_FRONTEND=noninteractive
log "Installing ${browser} dependencies."
npx playwright install-deps "${browser}"
apt-get clean
rm -rf /var/lib/apt/lists/*

# 3. Browser runtime
log "Installing ${browser} browser runtime."
npx playwright install "${browser}"
chmod -R a+rX "${PLAYWRIGHT_BROWSERS_PATH:-/ms-playwright}"
