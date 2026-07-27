## Notes

Enabling this feature installs the specified `pipx` packages globally using the shared `pipx` virtual environment at `/opt/pipx/shared`. The `minReleaseAge` option defaults to seven days. A non-negative integer passes pip's `--uploaded-prior-to` argument through `pipx`; an empty string omits the argument and disables the release-age restriction.

When the restriction is enabled, this environment must have `pip` 26.1 or newer to support the argument with older versions of `pipx`, such as the version installed by APT in Ubuntu 26.04. When this feature is used with the `apt-python` feature, the shared `pipx` virtual environment is already set up with the latest version of `pip`.
