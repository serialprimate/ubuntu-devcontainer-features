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

if [[ -n "${pip_uploaded_prior_to}" ]]; then
    require_command_minimum_version pip 26.1 /usr/local/lib/pipx/bin/python -m pip
fi

log "Installing pipx${pipx_version}."
/usr/local/lib/pipx/bin/python -m pip install "${pip_install_args[@]}" "pipx${pipx_version}"

log "Linking the pipx executable."
ln -s /usr/local/lib/pipx/bin/pipx /usr/local/bin/pipx
