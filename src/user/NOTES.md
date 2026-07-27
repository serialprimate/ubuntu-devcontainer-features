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
