
# APT Python (apt-python)

Install default python and optional pip, pipx, and venv apt OS packages.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/apt-python:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| installPip | Install pip. | boolean | true |
| installPipx | Install pipx. Requires venv to be installed. | boolean | true |
| installVenv | Install venv. | boolean | true |

## Notes

The version of pipx installed by APT in Ubuntu 26.04 does not support the `--cooldown` option. As a workaround, enabling pipx support in this feature will pre-initialise the standard shared pipx virtual environment at `/opt/pipx/shared` and upgrade it to use the latest version of pip so that the other devcontainer features of this repository can support a minimum release age option.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/apt-python/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
