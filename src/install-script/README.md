
# Install Script (install-script)

Fetch and execute an install script from a URL.

## Example Usage

```json
"features": {
    "ghcr.io/serialprimate/ubuntu-devcontainer-features/install-script:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| scriptURL | URL of the Bash-compatible install script to execute. Must not be empty. | string | - |
| scriptArgs | Dynamically evaluated, space-separated Bash word list of arguments passed to the install script. | string | - |
| envVars | Dynamically evaluated, space-separated Bash word list of NAME=VALUE environment variable assignments for the install script. | string | - |

## Notes

### Required tools and execution

This feature deliberately installs no dependencies. The consuming image or `devcontainer.json` must provide:

- a working certificate trust store for HTTPS URLs (normally the `ca-certificates` package);
- `curl` for fetching the script;
- Bash for evaluating the options and running the fetched script; and
- the `env`, `mkdir`, `mktemp`, and `rm` commands (normally provided by `coreutils`).

The fetched content must be a non-empty, Bash-compatible script. It is downloaded to a temporary file, executed with Bash as root, and then removed. Its shebang does not select another interpreter. Redirects are followed, transient fetch failures are retried up to three times, and any fetch or script failure fails the Feature installation. The URL is passed literally to `curl`; unlike `scriptArgs` and `envVars`, `scriptURL` is not dynamically evaluated.

### List separators and shell evaluation

Both `scriptArgs` and `envVars` are Bash word lists that are dynamically evaluated once, during Feature installation. Their separators and quoting rules are therefore shell rules rather than CSV rules:

- Unquoted spaces, tabs, and newlines separate list items. Repeated separators are equivalent to one separator.
- Commas are ordinary characters and remain part of an item.
- Single quotes preserve every enclosed character literally. Double quotes preserve whitespace while allowing Bash parameter, command, and arithmetic expansion.
- An unquoted backslash escapes the following character. Quotes and escaping backslashes used as syntax are removed before the value reaches the downloaded script.
- `""` or `''` creates an empty argument. For `envVars`, use `NAME=` to create an empty value.
- Parameter expansion, command substitution, arithmetic expansion, brace expansion, tilde expansion, word splitting, and pathname expansion follow Bash behavior. Because strict mode is enabled, an unguarded reference to an unset variable fails installation; `${NAME:-default}` can provide a fallback.
- A literal two-character `\n` sequence is not a separator. Supply an actual newline (for example, JSON's `\n` escape) to separate words, or quote that newline to keep it inside one word.

The option passes through three parsing layers: JSON, the Dev Container CLI's double-quoted shell assignment, and then this feature's dynamic Bash evaluation. A character that must reach the dynamic evaluation escaped may therefore need two levels of backslashes in `devcontainer.json`.

In particular, prefix dollar signs, double quotes, backticks, and backslashes with a transport backslash so the CLI's shell assignment does not expand or consume them first. JSON must encode that transport backslash as `\\`. Single quotes do not require transport escaping, so they are the simplest way to group fixed text. For example:

```json
"scriptArgs": "--name 'Jane Doe' --home \\\"\\$HOME\\\" --literal '\\$HOME' --escaped escaped\\ value --empty ''"
```

The JSON value gives the CLI `--home \"\$HOME\"`; its shell assignment gives this feature `--home "$HOME"`; and dynamic evaluation expands `HOME` while preserving it as one argument. The complete example produces these arguments:

1. `--name`
2. `Jane Doe`
3. `--home`
4. the dynamically expanded value of `HOME`
5. `--literal`
6. the literal text `$HOME`
7. `--escaped`
8. `escaped value`
9. `--empty`
10. an empty string

Each evaluated `envVars` item must be one `NAME=VALUE` assignment whose name matches `[A-Za-z_][A-Za-z0-9_]*`. Quote or escape separators to keep a value in one item; additional equals signs are part of the value. For example:

```json
"envVars": "GREETING=hello MESSAGE='hello world' HOME_COPY=\\\"\\$HOME\\\" LITERAL='\\$HOME' EMPTY="
```

Here `HOME_COPY` is dynamically expanded, while `LITERAL` reaches the script as the literal text `$HOME`.

The environment values are evaluated against the Feature installer's existing environment. Assignments earlier in `envVars` do not become available while later entries or `scriptArgs` are evaluated. The resulting assignments apply only to the downloaded script; they do not affect the `curl` request or persist in the container.

### Security

Dynamic Bash evaluation is intentionally powerful. Command substitutions and other shell constructs can execute code as root before the downloaded script starts. Use only trusted `scriptArgs` and `envVars` values, and only fetch scripts from trusted, integrity-controlled URLs. This feature does not verify a checksum or signature and does not redact credentials embedded in option values or URLs.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
