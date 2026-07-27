
# pipx Packages (pipx-packages)

Install pipx global packages.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/pipx-packages:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| pipxPackages | Comma-separated list of pipx global packages to install. | string | - |
| minReleaseAge | Minimum pipx release age in days. An empty string completely disables this feature. | string | 7 |

## Notes

Enabling this feature installs the specified `pipx` packages globally using the shared `pipx` virtual environment at `/opt/pipx/shared`. The `minReleaseAge` option defaults to seven days. A non-negative integer passes pip's `--uploaded-prior-to` argument through `pipx`; an empty string omits the argument and disables the release-age restriction.

When the restriction is enabled, this environment must have `pip` 26.1 or newer to support the argument with older versions of `pipx`, such as the version installed by APT in Ubuntu 26.04. When this feature is used with the `apt-python` feature, the shared `pipx` virtual environment is already set up with the latest version of `pip`.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/pipx-packages/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
