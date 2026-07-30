
# User (user)

Create a user with username, password, shell, and sudo access.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/user:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| username | Name of the user to create. | string | dev |
| passwordHash | Crypt-formatted password hash. Blank to leave the password unset. | string | - |
| configureSudo | Configure sudo access, passwordless when passwordHash is blank. | boolean | false |
| shell | Path to the user's login shell. | string | /bin/bash |
| userUid | Numeric UID for the user. | string | 1000 |
| userGid | Numeric GID for the user. | string | 1000 |
| groups | Space-separated list of groups to add the user to. | string | - |

## Notes

Creates a user with a configurable username, UID, GID, login shell, password hash, groups, and optional sudo access. If a pre-existing user has the requested UID, the feature removes that user before creating the requested account.

### Password

Leave `passwordHash` blank (the default) to leave the new account without a configured password. The account remains password-locked, as initially created by `useradd`. Set `passwordHash` to a crypt-formatted password hash to configure a password.

A crypt-formatted password hash can be generated with the following command:

```bash
# Example: Generate a crypt-formatted password hash for "mysecretpassword"
$ openssl passwd -1 -stdin <<< 'mysecretpassword'
```

### Sudo access

`configureSudo` controls whether this feature creates `/etc/sudoers.d/<username>`:

- When `configureSudo` is `false` (the default), the feature makes no sudo configuration, regardless of `passwordHash`.
- When `configureSudo` is `true` and `passwordHash` is set, sudo requires the user's password.
- When `configureSudo` is `true` and `passwordHash` is blank, sudo is passwordless (`NOPASSWD`).

The `sudo` command must already be installed when `configureSudo` is enabled.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/user/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
