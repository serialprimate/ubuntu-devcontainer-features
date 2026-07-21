
# User (user)

Create a development user with configurable identity, password, shell, and sudo access.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/user:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| username | Name of the user to create. | string | dev |
| configurePassword | Configure the account password when passwordCrypt is set. | boolean | true |
| passwordCrypt | Crypt-formatted password hash. Leave blank to create a password-locked account. | string | - |
| configureSudo | Grant the user password-protected sudo access. Requires passwordCrypt. | boolean | false |
| shell | Absolute path to the user's login shell. | string | /bin/bash |
| userUid | Numeric UID for the user. | string | 1000 |
| userGid | Numeric GID for the user. | string | 1000 |

## Notes

Creates a development user with a configurable username, UID, GID, login shell, password hash, and optional sudo access. If an existing user has the requested UID, the feature removes that user before creating the requested account.

`passwordCrypt` must be a crypt-formatted password hash. Leaving it blank creates a password-locked account. Enabling `configureSudo` requires a non-empty `passwordCrypt`. Generate `passwordCrypt` with `openssl passwd -1 -stdin <<< '<password>'`.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/user/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
