# Ubuntu Dev Container Features

## Introduction

This repository provides reusable Dev Container Features for assembling a practical Ubuntu development environment. Each feature is independently versioned and published as an OCI artifact to GitHub Container Registry (GHCR). All local dev container features' test scenarios are based on `ubuntu:latest`. The global integration scenario composes the local features to verify the complete toolchain and is based on `ubuntu:latest`.

Published features are addressed as `ghcr.io/serialprimate/ubuntu-devcontainer-features/<feature>:<major>`. The exact available tags are published by the release workflow.

## Repository Structure

```plaintext
.
├── .devcontainer/         # Development container configuration
├── .github/               # Validation, test, and release workflows
├── sample/                # Example devcontainer usage and assets
├── src/                   # Feature definitions
│   └── <feature>/
│       ├── devcontainer-feature.json
│       └── install.sh
├── test/                  # Feature and integration test scenarios
│   ├── <feature>/         # Per-feature test scenarios
│   └── _global/           # Full-toolchain integration scenarios
├── AGENTS.md              # Agent instructions for this repository
├── CONVENTIONS.md         # Conventions used across features, scripts, and tests
├── LICENSE
└── README.md
```

## Dev Container Features

| Feature | Feature Description |
| --- | --- |
| `apt-packages` | Install default apt OS packages. |
| `user` | Create a user with username, password, shell, groups, and sudo access. |
| `node` | Install Node.js apt packages from NodeSource. |
| `npm-packages` | Install global npm packages. |
| `apt-python` | Install default python and optional pip, pipx, and venv apt OS packages. |
| `pipx-packages` | Install pipx global packages. |
| `search-cli-tools` | Install developer search CLI tools. |
| `codex` | Install the Codex coding agent CLI as a global package. |
| `pi` | Install the Pi coding agent CLI as a global package. |
| `playwright` | Install the Playwright runtime and browser dependency. |

Feature-specific options are declared in each feature's `devcontainer-feature.json`.

### Dev Container Feature Dependencies

To remain flexible the features of this repository do not declare dependencies. For this reason, the user must compose a `node` feature or base image before an npm-dependent local feature. Likewise, the user must compose a `python` and/or `pipx` feature (e.g. `apt-python`) or base image before a pipx-dependent local feature.

### Minimum Release Age

Features that install npm packages provide an `npmMinReleaseAge` option whose value is passed directly to npm's `--min-release-age` option. Features that install pipx packages provide a `pipxCooldown` option whose value is passed directly to pipx's `--cooldown` option. Both default to `"7"`; an empty string omits the corresponding command option. Users are responsible for choosing values supported by the npm and pipx versions they provide.

The `apt-python` feature currently installs an older pipx version that does not support `--cooldown`. Set `pipxCooldown` to `""` when using a pipx-dependent feature with `apt-python`.

## References

### Dev Container Features Specifications

- [Dev Container Features specification](https://containers.dev/implementors/features/): Feature metadata, option resolution, versioning, and implementation requirements.
- [Feature distribution specification](https://containers.dev/implementors/features-distribution/): OCI distribution and collection publishing requirements.

### Dev Container CLI

- [Dev Container CLI](https://github.com/devcontainers/cli): CLI used locally and in CI to package and test features.
- [Dev Container CLI: Testing Dev Container Features](https://github.com/devcontainers/cli/blob/f683c29f64a20109b4453e5149807e390ff65133/docs/features/test.md): Testing features locally and in CI.

### Continuous Integration

- [Dev Container GitHub Action](https://github.com/devcontainers/action): GitHub Action used to validate, publish, and generate feature documentation.
- [GitHub Actions permissions](https://docs.github.com/actions/security-for-github-actions/security-guides/automatic-token-authentication): Permissions needed by the release workflow to publish packages and commit generated documentation.
