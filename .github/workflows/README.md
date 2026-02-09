# GitHub Actions Workflows

This directory contains automated CI/CD workflows for the repository. These workflows are based on [TheAlgorithms](https://github.com/TheAlgorithms) organization's best practices.

## Workflows

### 1. directory_writer.yml

**Trigger:** Push and Pull Request to `main` branch

**Purpose:** Automatically generates and updates the `DIRECTORY.md` file that lists all algorithm implementations.

**What it does:**
- Checks out the repository
- Sets up Python environment
- Runs the `build_directory_md.py` script
- Commits and pushes changes to DIRECTORY.md (on push events only)

### 2. verify_directory.yml

**Trigger:** Pull Request to `main` branch

**Purpose:** Verifies that the `DIRECTORY.md` file is up-to-date with the current repository structure.

**What it does:**
- Generates a new DIRECTORY.md
- Compares it with the existing one
- Fails the check if they differ
- Shows the differences in the workflow logs

### 3. lint.yml

**Trigger:** Push and Pull Request to `main` branch

**Purpose:** Enforces code quality and naming conventions.

**What it does:**
- Checks for files with spaces in names
- Ensures .mojo files use lowercase with underscores
- Checks for trailing whitespace in code and markdown files

### 4. check_links.yml

**Trigger:** Pull Request to `main` branch and weekly schedule (Mondays at 00:00 UTC)

**Purpose:** Validates all links in markdown files to prevent broken links.

**What it does:**
- Scans all markdown files
- Checks if external links are accessible
- Reports broken or unreachable links

## Configuration Files

### markdown-link-check-config.json

Configuration for the link checker workflow:
- Ignores localhost URLs
- Sets timeout and retry policies
- Configures HTTP headers for GitHub URLs

## Adding New Workflows

When adding new workflows, follow these guidelines:

1. Use descriptive names for workflow files
2. Add appropriate triggers (push, pull_request, schedule, etc.)
3. Include comments explaining complex steps
4. Use the latest versions of GitHub Actions
5. Test workflows in a fork before merging

## Permissions

The `directory_writer.yml` workflow requires `contents: write` permission to commit changes. Other workflows use default read permissions.

## Related Scripts

The workflows use scripts from the `/scripts` directory:
- `build_directory_md.py` - Generates the DIRECTORY.md file

See `/scripts/README.md` for more information about these scripts.
