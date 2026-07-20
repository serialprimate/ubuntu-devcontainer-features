## Notes

Creates a development user with a configurable username, UID, GID, login shell, password hash, and optional sudo access. If an existing user has the requested UID, the feature removes that user before creating the requested account.

`passwordCrypt` must be a crypt-formatted password hash. Leaving it blank creates a password-locked account. Enabling `configureSudo` requires a non-empty `passwordCrypt`. Generate `passwordCrypt` with `openssl passwd -1 -stdin <<< '<password>'`.