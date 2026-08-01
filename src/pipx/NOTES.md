## Notes

This feature requires `python3` with virtual environment support. It installs pipx in `/usr/local/lib/pipx` and links `/usr/local/bin/pipx` to the virtual environment's executable.

`pipUploadedPriorTo` accepts the same values as pip's `--uploaded-prior-to` option, including ISO 8601 datetimes and durations such as `P7D`. The default excludes releases uploaded within the last seven days; an empty string disables the restriction. The installed pip must support this option, and the configured package index must provide upload-time metadata. Set `venvInstallPipUpgrade` to `true` to upgrade the virtual environment's default pip before installing pipx.

This feature conflicts with `apt-python` when that feature's `installPipx` option is enabled. Set `installPipx` to `false` when composing the features.
