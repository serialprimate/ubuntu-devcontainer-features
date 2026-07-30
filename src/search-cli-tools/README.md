
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
| npxMinReleaseAge | Value passed to npm's --min-release-age option in days. An empty string omits the option. | string | 7 |
| pipxCooldown | Value passed to pipx's --cooldown option in days. An empty string omits the option. | string | 7 |

## Notes

The `npxMinReleaseAge` value applies to the npm installations of Context7 and Firecrawl and is passed directly to npm's `--min-release-age` option. The `pipxCooldown` value applies to the pipx installation of Tavily and is passed directly to pipx's `--cooldown` option. An empty string omits the corresponding option. Users are responsible for choosing values supported by their npm and pipx versions.

The version of pipx installed by the `apt-python` feature does not support `--cooldown`, so `pipxCooldown` must be empty when the features are used together.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/search-cli-tools/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
