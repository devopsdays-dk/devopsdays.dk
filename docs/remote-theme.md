---
maintainer: lakruzz
---

# Remote Theme & Dual Repo Setup

## Understanding the Architecture

This repository uses Jekyll's `remote_theme` feature to inherit from the [devopsdays-dk/minimal-mistakes](https://github.com/devopsdays-dk/minimal-mistakes) theme repository. This is a **dual repository setup** that enables us to keep this repo lean while allowing for flexible customization.

In `src/_config.yml`, you'll see:

```yaml
remote_theme: devopsdays-dk/minimal-mistakes
```

This tells Jekyll to download and use the theme from that GitHub repository during the build process.

## How It Works

### Theme Inheritance & Override

Jekyll follows a clear precedence order:

1. **Local files first**: Any files in *this* repo (devopsdays.dk) override the theme
2. **Theme files second**: If a file doesn't exist locally, Jekyll uses the version from the theme repo

So if you create a file like `src/_layouts/custom-page.html` here, it will be used instead of any `_layouts/custom-page.html` in the theme repo.

This means you can:

- **Override theme layouts**: Create `src/_layouts/event.html` to customize event pages
- **Add theme includes**: Create `src/_includes/custom-header.html` for reusable components
- **Customize styles**: Add SCSS files to `src/_sass/` that extend or override theme styles
- **Extend collections**: Add your own `_pages/`, `_posts/`, `_events/` with custom frontmatter

### What's in Each Repo

**devopsdays.dk repo** (this one):

- Content: events, posts, pages, stories
- Configuration: site title, plugins, navigation
- Local overrides: custom layouts, includes, styles specific to Denmark
- Minimal-mistakes customizations: Danish skin (`_dod.scss`), responsive image handling

**minimal-mistakes theme repo** (devopsdays-dk fork):

- Base layouts and includes
- Default styling and theme infrastructure
- Components shared across all sites using this theme
- Plugins and global configuration

## The Development Process

### When to Add Locally vs. in the Theme

**Start here locally if:**

- It's specific to the Danish DevOpsDays site
- You're experimenting with a new layout or component
- It's not mature enough to be a general-purpose theme feature
- It's configuration data (navigation, authors, etc.)

**Belongs in the theme repo if:**

- It's a general-purpose layout or component
- Other sites using minimal-mistakes would benefit from it
- It's feature-complete and stable
- It's core theme infrastructure

### Example: Adding a New Layout

Let's say you want to create a new "case-study" layout:

**Phase 1: Local Development** (this repo)

1. Create `src/_layouts/case-study.html` here
2. Develop and test it locally
3. Use it in your content via frontmatter: `layout: case-study`
4. Refine until it's solid and well-tested

**Phase 2: Move to Theme** (when ready)

1. Once the layout is feature-complete and widely useful, propose it as a PR to the [minimal-mistakes theme repo](https://github.com/devopsdays-dk/minimal-mistakes)
2. After it's merged into the theme, you can remove it from this repo
3. Jekyll will automatically use the theme version

**Benefits:**

- This repo stays focused and easy to navigate
- The theme becomes more robust and reusable
- Other sites can benefit from your innovations
- Clear separation between site-specific and shared code

### Example: Overriding a Theme Include

If you need to customize something from the theme:

1. Check what exists in the theme repo's `_includes/` folder
2. Copy it to `src/_includes/` in this repo
3. Make your customizations
4. Your version will be used instead of the theme's version
5. If you improve it, consider proposing it back to the theme repo

## When You Need to Fix the Theme

Sometimes you'll find issues in the theme that affect this site. Here's the workflow:

1. **Identify the problem**: Is it in this repo or the theme?
   - Check if `src/` has a local override that might be the issue
   - Check the [theme repo](https://github.com/devopsdays-dk/minimal-mistakes) to see the original

2. **Fix locally first** (if you need it urgently):
   - Create or override the file in `src/` with the fix
   - Document why it's a local override (add a comment)

3. **Fix in the theme** (for permanent solution):
   - Open an issue or PR in the [minimal-mistakes theme repo](https://github.com/devopsdays-dk/minimal-mistakes)
   - Once merged, remove the local override from this repo if you added one

4. **Update the remote_theme reference** if needed:
   - If the fix is in a new theme release, you may need to update the theme version
   - Jekyll pins to `main` by default; you can specify a branch or tag in `_config.yml` if needed

## Troubleshooting

### Changes not showing up?

- Restart Jekyll: `bundle exec jekyll serve`
- Clear cache: `rm -rf .jekyll-cache/` or `bundle exec jekyll clean`
- Check that your local file path matches the theme's structure exactly

### Not sure if something is in the theme or local?

- Search this repo with `grep -r "filename" src/`
- Check the [theme repo](https://github.com/devopsdays-dk/minimal-mistakes)
- Look at the generated `_site/` folder to see what got built

### Want to see what the theme looks like?

- Visit the [minimal-mistakes live demo](https://mmistakes.github.io/minimal-mistakes/)
- Check the [minimal-mistakes documentation](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/)

## Key Takeaway

This dual-repo setup gives you the best of both worlds:

- **Flexibility**: Customize anything you need locally without waiting for theme updates
- **Cleanliness**: Keep this repo focused on Danish DevOpsDays content and configuration
- **Community**: Improvements can flow back to the shared theme for the benefit of all

Happy hacking! 🚀
