#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
install_brave="${INSTALLBRAVE:-true}"
install_context7="${INSTALLCONTEXT7:-true}"
install_firecrawl="${INSTALLFIRECRAWL:-true}"
install_tavily="${INSTALLTAVILY:-true}"
min_release_age="${MINRELEASEAGE:-7}"

# Logging functions.
log() { printf '%s\n' "$*"; }
error() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Check option compatibility.
for option in "${install_brave}" "${install_context7}" "${install_firecrawl}" "${install_tavily}"; do
    case "${option}" in
        true|false) ;;
        *) error "Boolean options must be true or false." ;;
    esac
done
case "${min_release_age}" in ''|*[!0-9]*) error "MINRELEASEAGE must be a non-negative integer." ;; esac

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
if [ "${install_context7}" = "true" ] || [ "${install_firecrawl}" = "true" ]; then
    require_command npm
fi
if [ "${install_brave}" = "true" ]; then
    require_command curl
    require_command sh
fi
if [ "${install_tavily}" = "true" ]; then
    require_command pipx
fi

# Installation

# Install functions.
# No install functions are required

# Install packages.
# 1. Brave CLI
if [ "${install_brave}" = "true" ]; then
    log "Installing Brave CLI."
    BX_INSTALL_DIR="/usr/local/bin" sh -c "$(curl -fsSL https://raw.githubusercontent.com/brave/brave-search-cli/main/scripts/install.sh)"
fi

# 2. Context7 CLI
if [ "${install_context7}" = "true" ]; then
    log "Installing Context7 CLI."
    npm install --global --ignore-scripts --min-release-age="${min_release_age}" ctx7
fi

# 3. Firecrawl CLI
if [ "${install_firecrawl}" = "true" ]; then
    log "Installing Firecrawl CLI."
    npm install --global --ignore-scripts --min-release-age="${min_release_age}" firecrawl-cli
fi

# 4. Tavily CLI
if [ "${install_tavily}" = "true" ]; then
    log "Installing Tavily CLI."
    pipx install --global --pip-args="--uploaded-prior-to=P${min_release_age}D" tavily-cli
fi
