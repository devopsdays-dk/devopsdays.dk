# Importing Speakers from Sessionize

This guide explains how to import accepted speakers from Sessionize into the DevOpsDays website.

## Overview

The import process uses a Ruby script (`.scripts/import_speakers.rb`) that:

- Fetches speaker data from Sessionize API
- Generates URL-friendly slugs from speaker names
- Downloads speaker profile pictures  
- Creates speaker profile markdown files in `src/_profiles/`

## Quick Start

### 1. Fetch Sessionize Data

Since sessionize.com may not be accessible from all environments, fetch the data from a machine with internet access:

```bash
# Using the provided script
./.scripts/fetch_sessionize.sh

# Or manually with curl
curl -s "https://sessionize.com/api/v2/op1603dq/view/All" -o temp/sessionize-data.json

# Or download from your browser:
# https://sessionize.com/api/v2/op1603dq/view/All
```

### 2. Preview the Import (Recommended)

Run a dry-run to see what will be created:

```bash
ruby .scripts/import_speakers.rb --file temp/sessionize-data.json --dry-run
```

### 3. Run the Import

```bash
ruby .scripts/import_speakers.rb --file temp/sessionize-data.json
```

### 4. Verify and Build

```bash
# Build the site
bundle exec rake jekyll:build

# Validate HTML and links
bundle exec rake proofer:check

# Preview locally
bundle exec rake jekyll:serve
```

## Script Options

```bash
ruby .scripts/import_speakers.rb [OPTIONS]

Options:
  --file FILE       Load data from local JSON file
  --url URL         Fetch directly from Sessionize API URL
  --event EVENT     Event ID to assign speakers (default: 2026-cph)
  --dry-run         Preview changes without creating files
  --help            Show help message
```

## What Gets Created

For each speaker, the script creates:

1. **Profile markdown file**: `src/_profiles/<slug>.md`
   - Contains speaker name, headline, bio, social links
   - Tagged with role `speaker` and event `2026-cph`
   - Preserves Sessionize ID and session references

2. **Profile picture**: `src/assets/images/profiles/<slug>.webp`
   - Downloaded from Sessionize CDN
   - Converted to WebP format (consistent with existing profiles)

## Slug Generation

Speaker names are converted to URL-friendly slugs:

- `"John Doe"` → `john-doe`
- `"Søren Møller"` → `soren-moller`
- `"María José García"` → `maria-jose-garcia`

The script automatically transliterates common European characters (å, ä, ö, ñ, etc.) to English equivalents.

## Troubleshooting

### Cannot Access sessionize.com

If you get connection errors:

- The domain is blocked in some environments (GitHub Codespaces)
- Fetch the JSON file from your local machine
- Upload it to `temp/sessionize-data.json` in the repository

### Image Downloads Fail

If profile pictures fail to download:

- Check internet connectivity to the image CDN
- Images are optional - profiles will still be created
- You can manually download and add images later

### Duplicate Speakers

The script automatically deduplicates speakers by Sessionize ID. It's safe to run multiple times - existing files will be overwritten with updated data.

## Manual Profile Creation

If you need to create or edit a profile manually, follow this template:

```yaml
---
name: Speaker Full Name
headline: Job Title or Tagline
image: filename.webp
company: 
email: 
cell: 
pronoun: 
location: 
social:
  x: twitter-username
  linkedin: linkedin-username
  github: github-username
  website: https://example.com
  sessionize: https://sessionize.com/username
roles:
  - speaker
events:
  - 2026-cph
sessionize:
  id: sessionize-id
  sessions:
    - session-id
---

Speaker bio content goes here...
```

## For More Information

See the full documentation in the script itself:

```bash
ruby .scripts/import_speakers.rb --help
```
