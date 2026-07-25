
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
| minReleaseAge | Minimum release age in days for package installation. | string | 7 |

## Notes

Enabling this feature will install the specified `pipx` packages globally using the shared `pipx` virtual environment at `/opt/pipx/shared`. As a security feature, this environment must have a minimum `pip` release of 26.1 so as to support the minimum release age option for older versions of `pipx`, such as that installed by APT in Ubuntu 26.04. When using this devcontainer feature with the `apt-python` feature, the shared `pipx` virtual environment will already be setup with the latest version of `pip`.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/pipx-packages/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
