
# Search CLI Tools (search-cli-tools)

Install developer search CLI tools.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/search-cli-tools:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| installBrave | Install the Brave CLI. | boolean | true |
| installContext7 | Install the Context7 CLI. | boolean | true |
| installFirecrawl | Install the Firecrawl CLI. | boolean | true |
| installTavily | Install the Tavily CLI. | boolean | true |
| minReleaseAge | Minimum npm and pipx release age in days. An empty string completely disables this feature. | string | 7 |

## Notes

The `minReleaseAge` option defaults to seven days and applies to the npm installations of Context7 and Firecrawl and the pipx installation of Tavily. A non-negative integer passes the corresponding npm `--min-release-age` and pip `--uploaded-prior-to` arguments; an empty string omits both arguments and disables the release-age restrictions.

Enabling Tavily installs the `tavily-cli` package globally using the shared `pipx` virtual environment at `/opt/pipx/shared`. When the release-age restriction is enabled, this environment must have `pip` 26.1 or newer to support the argument with older versions of `pipx`, such as the version installed by APT in Ubuntu 26.04. When this feature is used with the `apt-python` feature, the shared `pipx` virtual environment is already set up with the latest version of `pip`.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/search-cli-tools/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
