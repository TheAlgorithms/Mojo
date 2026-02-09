# Scripts

This directory contains automation scripts used in the repository's CI/CD workflows.

## build_directory_md.py

Automatically generates the `DIRECTORY.md` file that lists all algorithm implementations in the repository.

### Usage

```bash
python3 scripts/build_directory_md.py <Language> <Base Path> <File Extensions>
```

### Example

```bash
python3 scripts/build_directory_md.py Mojo . .mojo > DIRECTORY.md
```

### Arguments

- `Language`: The programming language name (e.g., "Mojo")
- `Base Path`: The base directory to search (usually ".")
- `File Extensions`: Comma-separated list of file extensions to include (e.g., ".mojo")

### Features

- Automatically discovers all algorithm files
- Generates a hierarchical directory structure
- Formats filenames into readable titles
- Excludes hidden directories and common ignore patterns
- Creates markdown links to each file

This script is automatically run by the `directory_writer` GitHub Actions workflow on every push and pull request.
