
# pipx (pipx)

Install pipx.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/pipx:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| pipxVersion | Python version specifier appended to pipx (for example, ==1.8.0 or >=1,<2). | string | - |
| pipUploadedPriorTo | Value passed to pip's --uploaded-prior-to option. An empty string omits the option. | string | P7D |
| venvInstallPipUpgrade | Upgrade pip in the virtual environment before installing pipx. | boolean | false |

## Notes

This feature requires `python3` with virtual environment support. It installs pipx in `/usr/local/lib/pipx` and links `/usr/local/bin/pipx` to the virtual environment's executable.

`pipUploadedPriorTo` accepts the same values as pip's `--uploaded-prior-to` option, including ISO 8601 datetimes and durations such as `P7D`. The default excludes releases uploaded within the last seven days; an empty string disables the restriction. The installed pip must support this option, and the configured package index must provide upload-time metadata. Set `venvInstallPipUpgrade` to `true` to upgrade the virtual environment's default pip before installing pipx.

This feature conflicts with `apt-python` when that feature's `installPipx` option is enabled. Set `installPipx` to `false` when composing the features.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
