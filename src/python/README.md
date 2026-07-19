
# Python (python)

Install Python, pip, pipx, and optional development tools.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/python:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Python version to install. | string | 3.14 |
| installPipx | Install pipx. | boolean | true |
| installVenv | Ensure venv support is available. | boolean | true |
| installRuff | Install ruff via pipx. | boolean | true |
| installPyright | Install pyright via npm; requires Node.js and npm. | boolean | false |
| minReleaseAge | Minimum release age in days for npm and PyPI installation. | string | 7 |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/python/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
