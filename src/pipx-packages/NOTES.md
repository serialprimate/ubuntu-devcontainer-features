## Notes

Enabling this feature will install the specified `pipx` packages globally using the shared `pipx` virtual environment at `/opt/pipx/shared`. As a security feature, this environment must have a minimum `pip` release of 26.1 so as to support the minimum release age option for older versions of `pipx`, such as that installed by APT in Ubuntu 26.04. When using this devcontainer feature with the `apt-python` feature, the shared `pipx` virtual environment will already be setup with the latest version of `pip`.
