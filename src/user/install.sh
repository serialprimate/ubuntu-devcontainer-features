#!/usr/bin/env bash
set -euo pipefail

# Inputs

# Collect options.
username="${USERNAME:-dev}"
password_hash="${PASSWORDHASH:-}"
configure_sudo="${CONFIGURESUDO:-false}"
shell="${SHELL:-/bin/bash}"
user_uid="${USERUID:-1000}"
user_gid="${USERGID:-1000}"
groups=()
if [ -n "${GROUPS:-}" ]; then
    IFS=',' read -r -a requested_groups <<< "${GROUPS}"
    for group in "${requested_groups[@]}"; do
        group="${group#"${group%%[![:space:]]*}"}"
        group="${group%"${group##*[![:space:]]}"}"
        if [ -n "${group}" ]; then
            groups+=("${group}")
        fi
    done
fi

# Logging functions.
log() { printf '%s\n' "$*"; }
error() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Check option compatibility.
[ -n "${username}" ] || error "USERNAME must not be empty."
case "${configure_sudo}" in
    true|false) ;;
    *) error "CONFIGURESUDO must be true or false." ;;
esac
case "${user_uid}" in ''|*[!0-9]*) error "UID must be a non-negative integer." ;; esac
case "${user_gid}" in ''|*[!0-9]*) error "GID must be a non-negative integer." ;; esac
[ -x "${shell}" ] || error "SHELL must be an installed executable: ${shell}"

# Prerequisites

# Check required commands.
require_command() { command -v "$1" >/dev/null 2>&1 || error "Required command not found: $1"; }
require_command getent
require_command groupadd
require_command groupdel
require_command id
require_command printenv
require_command cut
require_command useradd
require_command userdel
require_command usermod
require_command chmod
if [ "${configure_sudo}" = "true" ]; then
    require_command sudo
fi

# Installation

# Install functions.
remove_user_with_uid() {
    local existing_user
    if existing_user="$(getent passwd "${user_uid}" | cut -d: -f1)"; then
        log "Removing existing user ${existing_user} with UID ${user_uid}."
        userdel --remove "${existing_user}"
    fi
}
remove_group_with_gid() {
    local existing_group
    if existing_group="$(getent group "${user_gid}" | cut -d: -f1)"; then
        log "Removing existing group ${existing_group} with GID ${user_gid}."
        groupdel "${existing_group}"
    fi
}

# Install packages.
# 1. User and group
remove_user_with_uid
remove_group_with_gid

log "Creating user ${username}."
groupadd --gid "${user_gid}" "${username}"
useradd --uid "${user_uid}" --gid "${user_gid}" --create-home --shell "${shell}" "${username}"

# 2. Password
if [ -n "${password_hash}" ]; then
    log "Configuring password for ${username}."
    usermod --password "${password_hash}" "${username}"
fi

# 3. Groups
if [ ${#groups[@]} -gt 0 ]; then
    log "Adding ${username} to existing groups."
    for group in "${groups[@]}"; do
        if ! getent group "${group}" >/dev/null 2>&1; then
            log "Skipping missing group ${group}."
            continue
        fi
        usermod --append --groups "${group}" "${username}"
    done
fi

# 4. Sudo
if [ "${configure_sudo}" = "true" ]; then
    log "Granting sudo access to ${username}."
    if [ -n "${password_hash}" ]; then
        printf '%s ALL=(root) ALL\n' "${username}" > "/etc/sudoers.d/${username}"
    else
        printf '%s ALL=(root) NOPASSWD: ALL\n' "${username}" > "/etc/sudoers.d/${username}"
    fi
    chmod 0440 "/etc/sudoers.d/${username}"
fi
