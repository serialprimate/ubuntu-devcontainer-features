
# Playwright (playwright)

Install the Playwright runtime and optional browser dependencies.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/playwright:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Version of the Playwright package to install. | string | 1.61.0 |
| browser | Browser to install for Playwright. | string | chromium |
| installSystemDeps | Install the browser system dependencies. | boolean | true |
| minReleaseAge | Minimum release age in days for npm installation. | string | 7 |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/playwright/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
