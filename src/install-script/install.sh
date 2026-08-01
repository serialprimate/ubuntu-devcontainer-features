#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
script_url="${SCRIPTURL:-}"
raw_script_args="${SCRIPTARGS:-}"
raw_env_vars="${ENVVARS:-}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

# Check option compatibility.
[[ -n "${script_url}" ]] || error "The scriptURL option must not be empty."

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
require_command bash
require_command curl
require_command env
require_command mkdir
require_command mktemp
require_command rm

# Installation

# Install functions.
evaluate_word_list() {
    local raw_value="$1"
    local option_name="$2"
    local -n evaluated_values="$3"

    # ShellCheck cannot follow assignments through a nameref.
    # shellcheck disable=SC2034
    evaluated_values=()
    if [[ -n "${raw_value}" ]]; then
        # eval is intentional: these trusted options support Bash quoting and expansions.
        # shellcheck disable=SC2294
        eval "evaluated_values=(${raw_value})" || error "Could not evaluate the ${option_name} option."
    fi
}

# Install packages.
script_args=()
env_vars=()
evaluate_word_list "${raw_script_args}" scriptArgs script_args
evaluate_word_list "${raw_env_vars}" envVars env_vars

for env_var in "${env_vars[@]}"; do
    [[ "${env_var}" =~ ^[a-zA-Z_][a-zA-Z0-9_]*= ]] || error "The envVars entry must be a NAME=VALUE assignment: ${env_var}"
done

installer_path="$(mktemp "/tmp/install-script.XXXXXX")"

log "Fetching install script from ${script_url}."
if ! curl --fail --show-error --silent --location --retry 3 --output "${installer_path}" -- "${script_url}"; then
    rm -f "${installer_path}"
    error "Could not fetch install script from ${script_url}."
fi
if [[ ! -s "${installer_path}" ]]; then
    rm -f "${installer_path}"
    error "The fetched install script is empty."
fi

log "Executing install script."
bash_path="$(command -v bash)"
script_status=0
env "${env_vars[@]}" "${bash_path}" "${installer_path}" "${script_args[@]}" || script_status=$?
rm -f "${installer_path}"

if ((script_status != 0)); then
    error "The install script exited with status ${script_status}."
fi

log "Install script completed."
