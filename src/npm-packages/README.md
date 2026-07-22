
# npm Packages (npm-packages)

Install npm packages globally.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/npm-packages:1": {
        "npmGlobalPackages": "markdownlint-cli2"
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| npmGlobalPackages | Comma-separated list of npm packages to install globally. | string | - |
| minReleaseAge | Minimum release age in days for npm installation. | string | 7 |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/npm-packages/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
