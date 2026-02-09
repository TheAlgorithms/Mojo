# CI/CD Setup Documentation

This document describes the Continuous Integration and Continuous Deployment (CI/CD) setup for the Mojo algorithms repository, based on [TheAlgorithms](https://github.com/TheAlgorithms) organization standards.

## Overview

The CI/CD pipeline consists of four main workflows that automate repository maintenance, code quality checks, and documentation generation.

## Workflows Added

### 1. Directory Writer (`directory_writer.yml`)

**Purpose:** Automatically maintains the `DIRECTORY.md` file

**Triggers:**
- Push to `main` branch
- Pull requests to `main` branch

**Actions:**
- Generates an up-to-date list of all `.mojo` files
- Organizes them in a hierarchical structure
- Commits changes automatically (on push events)

**Benefits:**
- No manual maintenance of DIRECTORY.md required
- Always reflects current repository structure
- Improves discoverability of algorithms

### 2. Directory Verifier (`verify_directory.yml`)

**Purpose:** Ensures DIRECTORY.md stays synchronized with repository structure

**Triggers:**
- Pull requests to `main` branch

**Actions:**
- Generates a fresh DIRECTORY.md
- Compares with existing file
- Fails if differences are found

**Benefits:**
- Catches outdated documentation before merge
- Enforces consistency
- Provides clear error messages with diffs

### 3. Linter (`lint.yml`)

**Purpose:** Enforces code quality and naming conventions

**Triggers:**
- Push to `main` branch
- Pull requests to `main` branch

**Checks:**
- No spaces in filenames
- Lowercase with underscores for `.mojo` files
- No trailing whitespace

**Benefits:**
- Consistent file naming across repository
- Cleaner code
- Prevents common formatting issues

### 4. Link Checker (`check_links.yml`)

**Purpose:** Validates all links in markdown files

**Triggers:**
- Pull requests to `main` branch
- Weekly schedule (Mondays at 00:00 UTC)

**Actions:**
- Scans all markdown files
- Tests external links
- Reports broken links

**Benefits:**
- Prevents broken documentation links
- Maintains high documentation quality
- Catches link rot early

## Scripts Added

### `scripts/build_directory_md.py`

Python script that generates the DIRECTORY.md file by:
1. Walking through the repository
2. Finding all files with specified extensions
3. Creating a hierarchical markdown structure
4. Formatting filenames into readable titles

**Usage:**
```bash
python3 scripts/build_directory_md.py Mojo . .mojo > DIRECTORY.md
```

## Configuration Files

### `.github/markdown-link-check-config.json`

Configures the link checker with:
- Timeout settings (20s)
- Retry logic (3 attempts)
- Status code validation
- URL pattern ignoring (localhost)

## Files Created

```
.github/
├── workflows/
│   ├── check_links.yml
│   ├── directory_writer.yml
│   ├── lint.yml
│   ├── verify_directory.yml
│   └── README.md
├── markdown-link-check-config.json
└── CI_SETUP.md (this file)

scripts/
├── build_directory_md.py
└── README.md

DIRECTORY.md (updated)
```

## Permissions

The workflows use minimal permissions:
- `directory_writer.yml`: Requires `contents: write` to commit changes
- Other workflows: Use default read-only permissions

## Integration with TheAlgorithms

These workflows follow the same patterns used across all TheAlgorithms repositories:
- [TheAlgorithms/Python](https://github.com/TheAlgorithms/Python)
- [TheAlgorithms/Java](https://github.com/TheAlgorithms/Java)
- [TheAlgorithms/JavaScript](https://github.com/TheAlgorithms/JavaScript)
- And 40+ other language repositories

## Next Steps

1. **Test the workflows:** Push a commit to trigger the workflows
2. **Monitor Actions tab:** Check that all workflows run successfully
3. **Add more workflows:** Consider adding:
   - Mojo syntax checking (when available)
   - Performance benchmarking
   - Code coverage reporting
   - Automated releases

## Troubleshooting

### Directory Writer Not Committing

If the directory writer workflow runs but doesn't commit:
- Check that `DIRECTORY.md` actually changed
- Verify the workflow has `contents: write` permission
- Check the Actions logs for error messages

### Link Checker Failing

If the link checker reports false positives:
- Update `.github/markdown-link-check-config.json`
- Add patterns to `ignorePatterns`
- Adjust timeout or retry settings

### Lint Failures

If lint checks fail:
- Review the error messages in Actions logs
- Fix naming conventions (lowercase, underscores)
- Remove trailing whitespace
- Ensure no spaces in filenames

## References

- [TheAlgorithms/scripts](https://github.com/TheAlgorithms/scripts) - Original scripts repository
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Markdown Link Check Action](https://github.com/gaurav-nelson/github-action-markdown-link-check)
