#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
pipx_version="${PIPXVERSION-}"
pip_uploaded_prior_to="${PIPUPLOADEDPRIORTO-P7D}"
venv_install_pip_upgrade="${VENVINSTALLPIPUPGRADE-false}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

# Check option compatibility.
case "${venv_install_pip_upgrade}" in
    true | false) ;;
    *) error "VENVINSTALLPIPUPGRADE must be true or false." ;;
esac

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
require_command ln
require_command python3

require_python_module() { "$1" -c "import $2" >/dev/null 2>&1 || error "Required Python module not found: $2"; }
require_python_module python3 venv

# Installation

# Install functions.
# No install functions are required.

# Install packages.
pip_install_args=()
if [[ -n "${pip_uploaded_prior_to}" ]]; then
    pip_install_args+=(--uploaded-prior-to="${pip_uploaded_prior_to}")
fi

log "Creating the pipx virtual environment."
python3 -m venv /usr/local/lib/pipx

if [[ "${venv_install_pip_upgrade}" == "true" ]]; then
    log "Updating pip in the pipx virtual environment."
    /usr/local/lib/pipx/bin/python -m pip install --upgrade pip
fi

log "Installing pipx${pipx_version}."
/usr/local/lib/pipx/bin/python -m pip install "${pip_install_args[@]}" "pipx${pipx_version}"

log "Linking the pipx executable."
ln -s /usr/local/lib/pipx/bin/pipx /usr/local/bin/pipx
