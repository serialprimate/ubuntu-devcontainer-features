#!/usr/bin/env bash
set -euo pipefail

# Inputs
# Collect options.
python_version="${VERSION:-3.14}"
install_pipx="${INSTALLPIPX:-true}"
install_venv="${INSTALLVENV:-true}"
install_ruff="${INSTALLRUFF:-true}"
install_pyright="${INSTALLPYRIGHT:-false}"
min_release_age="${MINRELEASEAGE:-7}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Check option compatibility.
for option in "${install_pipx}" "${install_venv}" "${install_ruff}" "${install_pyright}"; do
    case "${option}" in
        true|false) ;;
        *) error "Boolean options must be true or false." ;;
    esac
done
[ "${install_ruff}" = "false" ] || [ "${install_pipx}" = "true" ] || error "INSTALLRUFF requires INSTALLPIPX to be true."
case "${min_release_age}" in ''|*[!0-9]*) error "MINRELEASEAGE must be a non-negative integer." ;; esac

# Prerequisites
# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
require_command apt-get
if [ "${install_pyright}" = "true" ]; then
    require_command npm
fi

# Installation
# Install functions.
install_apt_packages() {
    apt-get update
    apt-get install -y --no-install-recommends "$@"
    apt-get clean
    rm -rf /var/lib/apt/lists/*
}

# Prepare pipx's shared environment for release-age-aware installations.
initialize_pipx_shared_environment() {
    if [ ! -x /opt/pipx/shared/bin/python ]; then
        python3 -m venv /opt/pipx/shared
    fi
    /opt/pipx/shared/bin/python -m pip install --upgrade pip
}

# Install packages.
# 1. Python
packages=("python${python_version}" python3-pip)
if [ "${install_venv}" = "true" ]; then
    packages+=("python${python_version}-venv")
fi
if [ "${install_pipx}" = "true" ] || [ "${install_ruff}" = "true" ]; then
    packages+=(pipx)
fi

export DEBIAN_FRONTEND=noninteractive
log "Installing Python ${python_version}."
install_apt_packages "${packages[@]}"

# 2. Ruff
if [ "${install_ruff}" = "true" ]; then
    log "Installing Ruff."
    initialize_pipx_shared_environment
    pipx install --global --pip-args="--uploaded-prior-to=P${min_release_age}D" ruff
fi

# 3. Pyright
if [ "${install_pyright}" = "true" ]; then
    log "Installing Pyright."
    npm install --global --ignore-scripts --min-release-age="${min_release_age}" pyright
fi
