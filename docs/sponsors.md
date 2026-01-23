# Sponsors — Add, Update, and Insert

Purpose

- Explain how to add or update a sponsor profile, upload logos, and render sponsors on an event page.

Add a new sponsor

1. Add the logo image to `src/assets/images/profiles/` (recommended: `<id>-logo.png`).
1. Create a profile file at `src/_profiles/<id>.md` with frontmatter. Use the per-event `sponsorship:` mapping, for example:

```yaml
---
name: Eficode
type: sponsor
id: eficode
headline: Enterprise DevOps & Cloud Solutions
image: eficode-logo.png
company: Eficode
roles:
  - sponsor
events:
  - 2025-aarhus
  - 2026-cph
sponsorship:
  2025-aarhus: gold
  2026-cph: silver
---
```

1. Commit the profile and image.

Per-event sponsorship design

- `sponsorship` is a mapping keyed by event id. This lets you vary tiers per event (e.g., gold in one year, silver the next).
- Do not add a top-level `sponsorship_level` — the site now reads the `sponsorship[event_id]` value.

Render sponsors on an event page

- Use the include in the event markdown where you want the sponsor band to appear:

```liquid
{% raw %}{% include sponsors event="2025-aarhus" %}{% endraw %}
```

Notes for the include

- The include looks up `profile.sponsorship[event_id]` and groups sponsors by tier.
- If a profile lacks a mapping for the requested event, it will not be shown for that event.

CSS and images

- Sponsor styles live in `src/_sass/_sponsors.scss`. Ensure `src/assets/css/main.scss` imports it: `@import "sponsors";`.
- Logos are displayed inside fixed-size `.sponsor-logo-wrap` boxes per tier and use `object-fit: contain`.

Build & verify

- Local build:

```bash
bundle exec rake jekyll:build
```

- Verify pages:
  - `_site/events/2025-aarhus/index.html` — sponsors should be grouped by tier.
  - `_site/profiles/<id>/index.html` — sponsor profile pages should show logo inside the portrait box.
- If logos look wrong: hard-refresh browser cache (Ctrl/Cmd+Shift+R) and confirm `_site/assets/css/main.css` contains `.sponsor-logo` rules.

Caveats and best practices

- Image processing: the responsive-image plugin requires existing image files; missing images can break builds (ImageMagick errors). Always add the image file before referencing it.
- Prefer `profile.url` when building links where available, but the include currently builds profile links from `profile.id`.
- Add a CI check or small rake task to validate that for every `event` listed in a profile, a `sponsorship` entry exists. This prevents silent omissions.

Example quick check (one-off):

```bash
# show profiles missing sponsorship entries for their events
ruby -e "Dir['src/_profiles/*.md'].each{|f|d=YAML.load_file(f); next unless d['events']; missing=(d['events']- (d['sponsorship']||{}).keys); puts f if missing && missing.any? }"
```

Questions

- Want me to add the CI/rake validation and run a build now?
