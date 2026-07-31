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
if [[ "${install_context7}" = "true" ]] || [[ "${install_firecrawl}" = "true" ]]; then
    require_command npm
fi
if [[ "${install_brave}" = "true" ]]; then
    require_command curl
    require_command sh
fi
if [[ "${install_tavily}" = "true" ]]; then
    require_command pipx
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
