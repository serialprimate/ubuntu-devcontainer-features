
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
| minReleaseAge | Minimum release age in days for Context7, Firecrawl and Tavily CLI installation. | string | 7 |

## Notes

Enabling the install of the Tavily CLI will install the `tavily-cli` `pipx` package globally using the shared `pipx` virtual environment at `/opt/pipx/shared`. As a security feature, this environment must have a minimum `pip` release of 26.1 so as to support the minimum release age option for older versions of `pipx`, such as that installed by APT in Ubuntu 26.04. When using this devcontainer feature with the `apt-python` feature, the shared `pipx` virtual environment will already be setup with the latest version of `pip`.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/search-cli-tools/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
