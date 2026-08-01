#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
install_brave="${INSTALLBRAVE:-true}"
install_context7="${INSTALLCONTEXT7:-true}"
install_firecrawl="${INSTALLFIRECRAWL:-true}"
install_tavily="${INSTALLTAVILY:-true}"
npm_min_release_age="${NPMMINRELEASEAGE-7}"
pipx_cooldown="${PIPXCOOLDOWN-7}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

# Check option compatibility.
for option in "${install_brave}" "${install_context7}" "${install_firecrawl}" "${install_tavily}"; do
    case "${option}" in
        true | false) ;;
        *) error "Boolean options must be true or false." ;;
    esac
done

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
if [[ "${install_context7}" = "true" ]] || [[ "${install_firecrawl}" = "true" ]]; then
    require_command npm
    if [[ -n "${npm_min_release_age}" ]]; then
        require_command_minimum_version npm 11.10.0 npm
    fi
fi
if [[ "${install_brave}" = "true" ]]; then
    require_command curl
    require_command sh
fi
if [[ "${install_tavily}" = "true" ]]; then
    require_command pipx
    if [[ -n "${pipx_cooldown}" ]]; then
        require_command_minimum_version pipx 1.16.0 pipx
    fi
fi

# Installation

# Install functions.
# No install functions are required

# Install packages.
npm_install_args=(--global --ignore-scripts)
pipx_install_args=(--global)
if [[ -n "${npm_min_release_age}" ]]; then
    npm_install_args+=(--min-release-age="${npm_min_release_age}")
fi
if [[ -n "${pipx_cooldown}" ]]; then
    pipx_install_args+=(--cooldown="${pipx_cooldown}")
fi

# 1. Brave CLI
if [[ "${install_brave}" = "true" ]]; then
    log "Installing Brave CLI."
    brave_installer="$(curl -fsSL https://raw.githubusercontent.com/brave/brave-search-cli/main/scripts/install.sh)"
    BX_INSTALL_DIR="/usr/local/bin" sh -c "${brave_installer}"
fi

# 2. Context7 CLI
if [[ "${install_context7}" = "true" ]]; then
    log "Installing Context7 CLI."
    npm install "${npm_install_args[@]}" ctx7
fi

# 3. Firecrawl CLI
if [[ "${install_firecrawl}" = "true" ]]; then
    log "Installing Firecrawl CLI."
    npm install "${npm_install_args[@]}" firecrawl-cli
fi

# 4. Tavily CLI
if [[ "${install_tavily}" = "true" ]]; then
    log "Installing Tavily CLI."
    pipx install "${pipx_install_args[@]}" tavily-cli
fi
