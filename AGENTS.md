# Instructions for Agents

This repository is a collection of devcontainer features that can be used to build Ubuntu-based development containers.
We will be targeting Ubuntu latest as the base image for all features, tests and this repository's devcontainer configuration.

Refer to the README.md for more information.

## Scripts

All scripts are self consistent and cross-consistent with the layout, style, sections, conventions and patterns used by every other script of the same type/class. They are to use bash strict mode, and fail early with a clear message when an optional selected capability requires a missing prerequisite. It is not necessary to use TRAP or defensively program for unlikely/rare conditions. We will fail fast in those cases due to bash strict mode. We need only worry about our explicit checks for option inputs, compatibility, prerequisites etc as required or appropriate for the specific type/class of script.

All scripts use elegant and concise bash scripting with no code smells.

All scripts use comments to identify the separate sections and/or describe functions and/or important steps (cross-consistently!)

All log messages, including progress and error messages, should be handled cross-consistently for all script instances.

To mitigate the risk of poisoned packages, npm, pip, pipx installations use their equivalent minReleaseAge option that defaults to seven days. This is a common pattern across all features.

Follow script filenaming conventions and patterns for each type/class of script, cross-consistently.

You might see examples that do not follow these conventions, patterns and practices. These are legacy examples that have not yet been updated to the current conventions, patterns and practices. They are still valid examples, but they are not the best examples.

## Currency of All Files

The scripts in this repository are kept up to date with the latest versions of the software they install, and with the latest versions of the base image they are designed to run on. The scripts are also kept up to date with the latest conventions, patterns and practices for writing devcontainer features.

When making changes to the scripts, please ensure that they are consistent with the latest conventions, patterns and practices for writing devcontainer features and that their comments are up to date and accurate.

Keep all documentation (including this file) up to date with the latest repo conventions, scripting conventions,patterns and practices for writing devcontainer features and that their comments are up to date and accurate.

## Keep it Professional

All scripts, documentation and comments should be written in a professional manner. Every response to a message or prompt should be completed with verification, validation and testing of the code, and a clear explanation of the changes made, the reasons for the changes, and any potential impact on other scripts or features in the repository. Strict code quality should also be verified and validated, and any potential impact on other scripts or features in the repository should be clearly explained.
