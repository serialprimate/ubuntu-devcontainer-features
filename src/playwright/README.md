
# Playwright (playwright)

Install the Playwright runtime and browser dependency.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/playwright:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Version of the Playwright package to install. | string | latest |
| browser | Browser to install for Playwright. | string | chromium |
| npmMinReleaseAge | Value passed to npm's --min-release-age option in days. An empty string omits the option. | string | 7 |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/serialprimate/ubuntu-devcontainer-features/blob/main/src/playwright/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
