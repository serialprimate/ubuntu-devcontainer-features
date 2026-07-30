## Notes

Enabling this feature installs the specified `pipx` packages globally. The `pipxCooldown` value is passed directly to pipx's `--cooldown` option; an empty string omits the option. Users are responsible for choosing a value supported by their pipx version.

When the restriction is enabled, this environment must have `pip` 26.1 or newer to support the argument with older versions of `pipx`, such as the version installed by APT in Ubuntu 26.04. When this feature is used with the `apt-python` feature, the shared `pipx` virtual environment is already set up with the latest version of `pip`.
