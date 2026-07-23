## Notes

Creates a user with a configurable username, UID, GID, login shell, password hash, and optional sudo access. If a pre-existing user has the requested UID, the feature removes that user before creating the requested account.

The `passwordHash` option must be a crypt-formatted password hash. A crypt-formatted password hash can be generated with the following command:

```bash
# Example: Generate a crypt-formatted password hash for "mysecretpassword"
$ openssl passwd -1 -stdin <<< 'mysecretpassword'
```

The `configureSudo` option requires the `configurePassword` option to be `true` and a non-empty `passwordHash`.
