# Path-Specific Copilot Instructions

This directory contains path-specific custom instructions for GitHub Copilot. These instructions are automatically applied when Copilot is working with files that match the patterns specified in each file's frontmatter.

## How It Works

Each `.instructions.md` file in this directory:

1. **Has a YAML frontmatter block** with an `applyTo` field that specifies which files the instructions apply to (using glob patterns)
2. **Contains natural language instructions** in Markdown format that guide Copilot's behavior
3. **Is automatically loaded** by GitHub Copilot when working with matching files

## Current Instructions

- **`general.instructions.md`** - General development workflow instructions
  - Applies to: All files (`**`)
  - Covers: Temp folder usage, branch naming, git workflow, code style

- **`summary.instructions.md`** - Issue summary and comment workflow
  - Applies to: All files (`**`)
  - Covers: Creating issue comments, summary formatting, workflow efficiency

## Adding New Instructions

To add new path-specific instructions:

1. Create a new file named `{purpose}.instructions.md`
2. Add a YAML frontmatter block at the top:

   ```yaml
   ---
   applyTo: "pattern/**/*.ext"
   ---
   ```

3. Write your instructions in natural language using Markdown
4. Commit the file - it will be automatically picked up by Copilot

## Glob Pattern Examples

- `**` or `**/*` - All files in all directories
- `*.rb` - All Ruby files in the current directory
- `**/*.rb` - All Ruby files recursively
- `src/**/*.md` - All Markdown files in the src directory
- `**/{test,spec}/**/*` - All files in test or spec directories

## Learn More

- [GitHub Docs: Adding custom instructions for GitHub Copilot](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)
- [Repository-wide instructions](../copilot-instructions.md)
