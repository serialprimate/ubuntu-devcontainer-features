## Notes

The `npxMinReleaseAge` value applies to the npm installations of Context7 and Firecrawl and is passed directly to npm's `--min-release-age` option. The `pipxCooldown` value applies to the pipx installation of Tavily and is passed directly to pipx's `--cooldown` option. An empty string omits the corresponding option. Users are responsible for choosing values supported by their npm and pipx versions.

The version of pipx installed by the `apt-python` feature does not support `--cooldown`, so `pipxCooldown` must be empty when the features are used together.
