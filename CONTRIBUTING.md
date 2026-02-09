---
maintainer: lakruzz
---

# Contributing to devopsdays.dk

Thank you for your interest in contributing to the Danish DevOpsDays website! We're happy to have you here. This guide will help you get set up and start contributing.

## 🚀 Quick Start

There are two ways to set up your development environment:

### Option 1: GitHub Codespaces (Easiest)

No installation required! Just click the green "Code" button on the [GitHub repository](https://github.com/devopsdays-dk/devopsdays.dk) and select "Create codespace on main". The environment will be ready in minutes.

### Option 2: Local Dev Container

If you prefer to work locally, you'll need:

- **Git** – for version control
- **Docker** – to run the development container
- **VS Code** – with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

Once you have these installed:

1. Clone the repository: `git clone https://github.com/devopsdays-dk/devopsdays.dk.git`
2. Open the folder in VS Code
3. When prompted, reopen the folder in a container (or use the Command Palette: `Dev Containers: Reopen in Container`)
4. The environment will initialize automatically

See [devcontainers.md](./docs/devcontainers.md) for more detailed information about the dev container setup.

## 📁 Project Structure

```shell
devopsdays.dk/
├── src/                          # Jekyll source (the only place you edit!)
│   ├── _config.yml              # Main Jekyll configuration
│   ├── _data/                   # YAML data files (authors, navigation, etc.)
│   ├── _events/                 # Event markdown files
│   ├── _includes/               # Reusable HTML components
│   ├── _layouts/                # Page templates
│   ├── _pages/                  # Static pages (about, contact, etc.)
│   ├── _posts/                  # Blog posts
│   ├── _sass/                   # SCSS stylesheets
│   ├── _stories/                # Story collection
│   └── assets/                  # Images, CSS, JavaScript
├── docs/                        # Developer documentation
├── .devcontainer/               # Dev container configuration
├── .github/                     # GitHub workflows and actions
├── _site/                       # Built output (auto-generated, don't edit)
├── Gemfile                      # Ruby dependencies
├── CONTRIBUTING.md              # This file
├── README.md                    # Project overview
└── RESPONSIBLES                 # Maintainers list
```

## ⚙️ Configuration & Control Files

Outside the `src/` folder, here's what you should know about:

| File | Purpose |
| ---- | ------- |
| `Gemfile` | Ruby gem dependencies (Jekyll, plugins, themes) |
| `src/_config.yml` | Main Jekyll configuration (site title, theme, plugins, build settings) |
| `.devcontainer/` | Configuration for the dev container environment |
| `.github/workflows/` | Automated CI/CD pipelines (tests, linting, deployment) |
| `.githooks/` | Git hooks for pre-commit checks (linting, spell-check) |
| `.gitignore` | Files to exclude from git (node_modules,_site, temp/, etc.) |
| `cspell.json` | Spell-check configuration |
| `.markdownlint-cli2.jsonc` | Markdown linting rules |
| `RESPONSIBLES` | Maintainers and who to reach out to |

You typically won't need to edit these files unless you're making infrastructure changes.

## 🔨 Working with Jekyll

This site is built with [Jekyll](https://jekyllrb.com/), a static site generator. Here's a quick primer:

### The Basics

**Markdown with FrontMatter**: Content files (posts, pages, events) are markdown with YAML frontmatter:

```markdown
---
title: "My Event"
date: 2025-12-25
category: events
---

# This is my content

Written in **markdown** with support for *formatting*.
```

**Liquid Templates**: Jekyll uses [Liquid](https://shopify.github.io/liquid/) for dynamic content:

```liquid
{% for post in site.posts %}
  <h2>{{ post.title }}</h2>
  <p>{{ post.content }}</p>
{% endfor %}
```

**Collections**: We organize content into collections:

- `_events/` – Events and conferences
- `_posts/` – Blog articles
- `_stories/` – Community stories
- `_pages/` – Static pages

**Data Files**: In `_data/`, we have YAML files that provide shared data:

- `authors.yml` – Author information
- `navigation.yml` – Main navigation menu

**Theme System**: This site uses a remote theme from [devopsdays-dk/minimal-mistakes](https://github.com/devopsdays-dk/minimal-mistakes). Any layouts, includes, or styles you add here will override the theme versions. For a deep dive into how this works and when to add things locally vs. in the theme repo, see [remote-theme.md](./docs/remote-theme.md).

### Building & Serving

The site is built from the `src/` folder. To build and serve locally:

```bash
# With the current directory being the root of the workspace
# Running `bundle install` is a prerequsite but the devcontainer alrady did that
# So you shoul dbe good to go without it. 
# bundle install  
bundle exec jekyll serve --source src
```

Visit `http://localhost:4000` to see the live preview. Changes reload automatically!

Jekyll automatically disables some features in development builds (optimizations, analytics, giscus ...) Sometimes you would like to enable these features during development. Simply set the`JEKYLL_ENV` environment variable:

```bash
JEKYLL_ENV=production bundle exec jekyll serve --source src
```

See [git-hooks.md](./docs/git-hooks.md) and [giscus.md](./docs/giscus.md) for details on comments, pre-commit hooks, and other integrations.

## 📝 Making Changes

### Creating a Post or Event

1. Create a new file in `src/_events/` or `src/_posts/` with the naming convention: `YYYY-MM-DD-slug-title.md`
2. Add frontmatter at the top with metadata (title, date, category, etc.)
3. Write your content in markdown
4. Commit and push your changes

### Editing Pages

Pages live in `src/_pages/`. Edit the markdown directly, and the site will regenerate.

### Updating Navigation

Edit `src/_data/navigation.yml` to add or change menu items.

### Images & Assets

Place images in `src/assets/images/` and reference them in your markdown:

```markdown
![Alt text](/assets/images/my-image.png)
```

## 🔍 Code Style & Best Practices

- **Markdown**: Follow [CommonMark](https://commonmark.org/) standards
- **Linting**: Comply with he settings proofed by `markdownlint` automatically via git hooks (install pre-commit hooks if you haven't already)
- **Spell-check**: Enabled via `cspell.json` – add words to the ignore list if needed
- **Keep changesets focused**: One feature or fix per commit/PR
- **Keep it DRY**: Avoid duplicating code – use includes and layouts

## 🧪 Testing & Quality Checks

Before you push, the following checks run automatically:

- **Jekyll build** – Ensures the site builds without errors
- **Markdown linting** – Checks formatting and style
- **Spell-checking** – Catches typos (configured in `cspell.json`)
- **Link validation** – Verifies internal and external links work

All checks also run as GitHub Actions on each push.

## 🔀 Git Workflow

We use a simple workflow with the [gh-tt](https://github.com/devx-cafe/gh-tt) extension:

```bash
# Start work on an issue
gh tt workon -i 123              # or -t "Issue title"

# Make your changes, commit
git add .
git commit -m "Describe your changes"

# Wrap up and push
gh tt wrapup "Your commit message"

# When ready, deliver to main
gh tt deliver
```

See [general.instructions.md](./.github/instructions/general.instructions.md) for more details on our branching strategy.

## 🤖 GitHub Copilot Integration

This repository is configured with custom instructions for GitHub Copilot to help you get the most out of AI-assisted development.

### What's Configured

- **Repository-wide instructions**: [`.github/copilot-instructions.md`](./.github/copilot-instructions.md) provides comprehensive context about the Jekyll project structure, build process, and coding conventions
- **Path-specific instructions**: Additional guidance in [`.github/instructions/`](./.github/instructions/) for specific workflows like issue management and summaries
- **Automated setup**: [`.github/workflows/copilot-setup-steps.yml`](./.github/workflows/copilot-setup-steps.yml) ensures Copilot agents have a properly configured environment

### Using Copilot

If you have GitHub Copilot enabled:

1. **Copilot Chat** automatically uses these instructions when you ask questions about the repository
2. **Copilot Coding Agent** follows the setup steps and guidelines when making changes
3. **Custom instructions are applied** based on which files you're working with

The instructions help Copilot understand:

- How to build and test the Jekyll site
- Our git workflow with `gh-tt`
- Code conventions and best practices
- Pre-commit validation requirements

### Learn More

For more information about GitHub Copilot custom instructions:

- [GitHub Docs: Adding custom instructions for GitHub Copilot](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)
- View our [copilot-instructions.md](./.github/copilot-instructions.md) to see what guidance is provided

## 💬 Need Help?

- **Questions?** Drop by our [Slack](https://slack.devopsdays.dk)
- **Found a bug?** [Create an issue](https://github.com/devopsdays-dk/devopsdays.dk/issues)
- **Have feedback?** Comment on posts using Giscus (your GitHub account)
- **Reach out**: Check `RESPONSIBLES` for maintainer contact info

## 📚 Detailed Documentation

For deeper dives into specific topics, check the [docs/](./docs/) folder:

- [devcontainers.md](./docs/devcontainers.md) – Dev container setup and troubleshooting
- [giscus.md](./docs/giscus.md) – Comment system configuration
- [git-hooks.md](./docs/git-hooks.md) – Pre-commit hooks and local checks
- [remote-theme.md](./docs/remote-theme.md) – Understanding our dual repo setup with minimal-mistakes theme

## 🙏 Thank You!

Thanks for helping make the Danish DevOpsDays community stronger. Happy contributing!

---

**On behalf of the Danish DevOpsDays Organizers**  
_Lars Kruse_ [@lakruzz](https://github.com/lakruzz)
