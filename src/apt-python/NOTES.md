## Notes

The version of pipx installed by APT in Ubuntu 26.04 does not support the `--cooldown` option. As a workaround, enabling pipx support in this feature will pre-initialise the standard shared pipx virtual environment at `/opt/pipx/shared` and upgrade it to use the latest version of pip so that the other devcontainer features of this repository can support a minimum release age option.
