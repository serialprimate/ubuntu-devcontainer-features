
# pipx Packages (pipx-packages)

Install pipx packages globally.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/pipx-packages:1": {
        "pipxPackages": "black"
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| pipxPackages | Comma-separated list of packages to install globally with pipx. | string | - |
| minReleaseAge | Minimum release age in days for pipx installation. | string | 7 |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/pipx-packages/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
