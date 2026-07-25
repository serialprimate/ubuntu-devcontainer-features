
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
| configurePassword | Configure the account password when passwordHash is set. | boolean | true |
| passwordHash | Crypt-formatted password hash. Blank for a password-locked account. | string | - |
| configureSudo | Configure user password-protected sudo access. Requires passwordHash. | boolean | false |
| shell | Path to the user's login shell. | string | /bin/bash |
| userUid | Numeric UID for the user. | string | 1000 |
| userGid | Numeric GID for the user. | string | 1000 |
| groups | Comma-separated list of groups to add the user to. | string | - |

## Notes

Creates a user with a configurable username, UID, GID, login shell, password hash, groups, and sudo access. If a pre-existing user has the requested UID, the feature removes that user before creating the requested account.

The `passwordHash` option must be a crypt-formatted password hash. A crypt-formatted password hash can be generated with the following command:

```bash
# Example: Generate a crypt-formatted password hash for "mysecretpassword"
$ openssl passwd -1 -stdin <<< 'mysecretpassword'
```

The `configureSudo` option requires the `configurePassword` option to be `true` and a non-empty `passwordHash`.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/user/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
