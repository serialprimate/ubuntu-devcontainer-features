
# APT Python (apt-python)

Install Python and optional pip, pipx, and venv support.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/apt-python:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Python version to install. | string | 3.14 |
| installPip | Install pip. | boolean | true |
| installPipx | Install pipx. | boolean | true |
| installVenv | Ensure venv support is available. | boolean | true |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/apt-python/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
