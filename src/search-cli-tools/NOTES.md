## Notes

The `minReleaseAge` option defaults to seven days and applies to the npm installations of Context7 and Firecrawl and the pipx installation of Tavily. A non-negative integer passes the corresponding npm `--min-release-age` and pip `--uploaded-prior-to` arguments; an empty string omits both arguments and disables the release-age restrictions.

Enabling Tavily installs the `tavily-cli` package globally using the shared `pipx` virtual environment at `/opt/pipx/shared`. When the release-age restriction is enabled, this environment must have `pip` 26.1 or newer to support the argument with older versions of `pipx`, such as the version installed by APT in Ubuntu 26.04. When this feature is used with the `apt-python` feature, the shared `pipx` virtual environment is already set up with the latest version of `pip`.
