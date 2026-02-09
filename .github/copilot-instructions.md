# Jekyll Project - Copilot Instructions

<!--
These are repository-wide custom instructions for GitHub Copilot.
For more information about Copilot custom instructions, see:
https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot
-->

This document provides general instructions for working on a Jekyll-based project that uses a common toolchain including Rake and the `gh-tt` Git extension.

In general; Adhere to Ruby/Jekyll conventions and best practices. The instructions below cover project-specific workflows, environment setup, and code conventions to ensure a consistent development experience for both human developers and GitHub Copilot agents.

## Architecture and Tech Stack

- **Static Site Generator**: The site is built using **Jekyll**. The source code resides in the `src/` directory.
- **Build Output**: The final, generated static site is placed in the `_site/` directory. This directory is not checked into version control.
- **Styling**: We use **SCSS** for styling. The main stylesheet is `src/_sass/main.scss`, which gets compiled into `assets/css/style.css`.
- **Task Runner**: **Rake** is used to automate build and development tasks. See the `Rakefile` for details.
- **Containerization**: A `dockerfile` is provided to create a consistent development environment with Ruby, Bundler, and the GitHub CLI.

## Environment Setup for Copilot Agents

When setting up the development environment, GitHub Copilot agents should reference the following resources:

- **Primary reference**: `.github/workflows/copilot-setup-steps.yml` - Executable GitHub Actions workflow that sets up the environment before Copilot starts working
- **Container definition**: `dockerfile` - Defines the Ruby 3.3.0 base image with all system dependencies
- **DevContainer config**: `.devcontainer/ruby/devcontainer.json` - VS Code development container configuration

### Essential Setup Steps

1. **Ruby dependencies**: Run `bundle install` to install Jekyll and all gems from Gemfile
2. **Node.js tools**: Install `cspell`, `markdownlint-cli2`, and `@cspell/dict-da-dk` (required for pre-commit checks)
3. **Git hooks**: Configure git to use hooks from `.githooks` directory
4. **Validation**: Run `.githooks/pre-commit` to verify the environment is correctly configured

### Success Criteria

Before completing any work, the `.githooks/pre-commit` script must execute successfully with exit code 0. This script validates:

- Spelling (cspell)
- Markdown formatting (markdownlint-cli2)
- Jekyll build (bundle exec rake jekyll:build)
- HTML link validation (bundle exec rake proofer:check_external)

If the pre-commit hook fails, the issue is not resolved.

## Version Control & Issue Management

We do not use pull requests. Instead, we use the GitHub CLI extension [gh-tt](https://github.com/thetechcollective/gh-tt) to manage issues and branches.

### Branch Types and Naming

- **Issue branches** (e.g., `123-my-feature`): Created by developers with `gh tt workon -i ISSUE`. The issue number is prefixed to the branch name.
- **Copilot branches** (e.g., `copilot/update-feature`): Created for GitHub Copilot agents to work on. These branches do NOT follow the issue number prefix pattern.

### Extracting Issue Numbers from Branches

- **For issue branches**: The issue number is the numeric prefix before the first hyphen (e.g., `123-my-feature` → issue #123)
- **For copilot/ branches**: DO NOT attempt to extract an issue number from the branch name. These are working branches without embedded issue numbers.

When working on a `copilot/*` branch and you need to reference the related issue, it should be provided explicitly in the task context or retrieved through other means (e.g., branch metadata, issue assignment).

### Workflow Commands

- `gh tt workon [-i ISSUE | -t TITLE]`: Creates and switches to a new issue branch (e.g., `123-my-feature`).
- `gh tt wrapup [message]`: Stages all changes, commits them, and pushes the branch. This triggers the pre-commit hook locally and the 'wrapup' workflow when reaching GitHub.
- `gh tt deliver`: Squashes all branch commits into one commit on a branch named after the issue and prefixed with `ready/` It triggers the 'ready' workflow and prepares it for fast-forwarding into `main`. When a commit hits main it is automatically deployed by the 'deploy' workflow.
- `git sweep`: An alias defined in the .gitconfig file that fetches and prunes remote branches, then deletes any local branches that have been merged into `main`. It prepares your local repo for new work.

### Copilot Agent Workflow

When GitHub Copilot agents are assigned to work on an issue:

1. Copilot works on a `copilot/*` branch (created automatically)
2. Copilot makes changes and validates them against the pre-commit hook
3. When complete, a developer creates the proper issue branch: `gh tt workon -i <issue-number>`
4. Developer then integrates Copilot's work: `git reset --hard copilot/<branch-name>`
5. Developer proceeds with normal workflow (`gh tt wrapup`, `gh tt deliver`)

## Developer Workflow

The primary development workflow involves running a local server with live reload to see changes as you make them.

- **To start the local development server**:

  ```bash
  bundle exec rake jekyll:serve
  ```

  This command builds the site and serves it from `http://localhost:4000`. The `--livereload` flag ensures that the browser automatically refreshes when you save a file.

- **To build the site for production**:

  ```bash
  bundle exec rake build
  ```

  This command runs `bundle exec jekyll build` and places the output in the `_site` directory.

- **To validate HTML**:
  The `Rakefile` includes tasks to check for broken links using `html-proofer`.
  - `bundle exec rake proofer:check` (internal links only)
  - `bundle exec rake proofer:check_external` (includes external links)

The pre-commit hook in `.githooks/pre-commit` runs the internal link check before allowing a commit, ensuring that all internal links are valid. It can make sence to run that manually as a pre-check even on a dirty working tree before committing, to catch issues early.

  ```bash
  .githooks/pre-commit
  ```

## Code Conventions

- **Keep Changesets Small**: Keep changes focused on the issue at hand. Do not add unrelated changes or refactorings.
- **DRY (Don't Repeat Yourself)**: Avoid code duplication. Refactor repeated code into reusable functions or classes.
- **CLI Output**: Avoid adding `print` or `puts` statements to CLI tools. If nothing happened, nothing should be printed.
- **Jekyll Structure**: Follow standard Jekyll conventions. Content pages are in the root of `src/`, reusable modules are in `src/_includes/`, and layouts are in `src/_layouts/`.
- **Separation of Concerns**: Honor the principle of separating "what" (content in `.md` files) from "how" (presentation in layouts and includes). Use Jekyll's includes and layouts to keep Markdown files clean of HTML and scripts. When Markdown files are cluttered with HTML, identify reusable snippets to move into includes.
- **Collections**: All Jekyll collections should be configured with `defaults` in `_config.yml` to set common properties like `layout` and `permalink`. Individual files within collections should not set these properties unless they need to override the defaults. This keeps the collection files clean and maintainable.

## RAG (Retrieval-Augmented Generation)

Further details and project-specific instructions can be found in the `.github/instructions/` directory. These files contain specific instructions for handling different parts of the codebase and workflows.
