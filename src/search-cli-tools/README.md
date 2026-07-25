
# Search CLI Tools (search-cli-tools)

Install a set of developer search CLI tools.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/search-cli-tools:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| installBrave | Install the Brave CLI. | boolean | true |
| installContext7 | Install the Context7 CLI. | boolean | true |
| installFirecrawl | Install the Firecrawl CLI. | boolean | true |
| installTavily | Install the Tavily CLI. | boolean | true |
| minReleaseAge | Minimum release age in days for npm-based CLI installation. | string | 7 |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/search-cli-tools/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
