
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

The version of pipx installed by APT in Ubuntu 26.04 does not support the `--cooldown` option. Features using this APT-provided pipx must omit that option.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/apt-python/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
