# Sessionize Import Mapping Instructions

This document provides detailed instructions for importing speakers and sessions from Sessionize into the DevOpsDays website. Use this as a reference for future imports.

## Overview

The Sessionize import process involves:
1. Fetching data from the Sessionize API
2. Creating speaker profiles in the `_profiles` collection
3. Creating talk entries in the `_talks` collection
4. Linking speakers to their talks (bidirectional)
5. Downloading and converting speaker profile photos

## Data Structure

### Sessionize API Response

The API returns a JSON object with the following structure:

```json
{
  "speakers": [
    {
      "id": "speaker-uuid",
      "firstName": "First",
      "lastName": "Last",
      "fullName": "First Last",
      "bio": "Speaker biography...",
      "tagLine": "Speaker headline/title",
      "profilePicture": "https://sessionize.com/image/...",
      "links": [
        {
          "title": "X (Twitter)",
          "url": "https://x.com/username",
          "linkType": "Twitter"
        },
        {
          "title": "LinkedIn",
          "url": "https://linkedin.com/in/username",
          "linkType": "LinkedIn"
        }
        // ... more links
      ],
      "sessions": [session_id1, session_id2]
    }
  ],
  "sessions": [
    {
      "id": "session_id",
      "title": "Session Title",
      "description": "Session description...",
      "speakers": ["speaker-uuid1", "speaker-uuid2"]
    }
  ]
}
```

## Mapping to Jekyll Collections

### 1. Speaker Profiles (_profiles collection)

**File naming**: `src/_profiles/{slug}.md`

**Slug generation**:
- Combine firstName and lastName with space
- Convert to lowercase
- Transliterate special characters (å→a, ø→o, ä→a, etc.)
- Replace spaces with hyphens
- Remove non-alphanumeric characters except hyphens
- Result: `"Søren Møller-Hansen"` → `"soren-moller-hansen"`

**Frontmatter mapping**:
```yaml
---
name: {fullName}
headline: {tagLine}
image: {slug}.webp
company: 
email: 
cell: 
pronoun: 
location: 
social:
  x: {extracted from links where linkType == "Twitter"}
  linkedin: {extracted from links where linkType == "LinkedIn"}
  github: {extracted from links where linkType == "GitHub"}
  website: {extracted from links where linkType == "Blog"}
  sessionize: {extracted from links where linkType == "Sessionize"}
roles:
  - speaker
events:
  - {event-id}  # e.g., 2026-cph
talks:
  - {talk-slug-1}
  - {talk-slug-2}
sessionize:
  id: {id}
  sessions:
    - {session_id}
---

{bio}
```

**Image handling**:
- Download from `profilePicture` URL
- Convert to WebP format (85% quality, 400x400px)
- Save as `src/assets/images/profiles/{slug}.webp`
- Use ImageMagick: `convert source.jpg -quality 85 dest.webp`

### 2. Talk Entries (_talks collection)

**File naming**: `src/_talks/{talk-slug}.md`

**Talk slug generation**:
- Take session title
- Convert to lowercase
- Remove special characters (keep alphanumeric and spaces)
- Replace spaces with hyphens
- Remove consecutive hyphens
- Result: `"Platform Engineering 101!"` → `"platform-engineering-101"`

**Frontmatter mapping**:

For single speaker:
```yaml
---
id: {talk-slug}
title: "{title}"
speaker: {speaker-slug}
excerpt: "{description first 200 chars}..."
events:
  - {event-id}
sessionize:
  id: {session-id}
---

{description}
```

For multiple speakers:
```yaml
---
id: {talk-slug}
title: "{title}"
speakers:
  - {speaker-slug-1}
  - {speaker-slug-2}
excerpt: "{description first 200 chars}..."
events:
  - {event-id}
sessionize:
  id: {session-id}
---

{description}
```

### 3. Bidirectional Linking

**Speaker → Talks**:
- Add `talks:` array in speaker profile frontmatter
- List all talk slugs where speaker appears
- Update happens after talk files are created

**Talk → Speakers**:
- Use `speaker:` field for single speaker
- Use `speakers:` array for multiple speakers
- Layout handles both cases automatically

## Layout Updates Required

### Profile Layout (`src/_layouts/profile.html`)

Add talks section after social links:
```liquid
{% if page.talks %}
  <div class="profile-talks">
    <h2 class="profile-talks-title">Talks</h2>
    <div class="profile-talks-list">
      {% for talk_id in page.talks %}
        {% for talk in site.talks %}
          {% assign talk_file_id = talk.path | split: '/' | last | remove: '.md' %}
          {% if talk_file_id == talk_id %}
            <div class="profile-talk-item">
              <h3 class="profile-talk-title">
                <a href="/talks/{{ talk_id }}/">{{ talk.title }}</a>
              </h3>
              {% if talk.excerpt %}
                <p class="profile-talk-excerpt">{{ talk.excerpt }}</p>
              {% endif %}
            </div>
          {% endif %}
        {% endfor %}
      {% endfor %}
    </div>
  </div>
{% endif %}
```

### Talk Layout (`src/_layouts/talk.html`)

Update speaker section to handle both singular and plural:
```liquid
{% if page.speaker or page.speakers %}
  <div class="talk-speaker-box">
    <h3 class="talk-speaker-label">Speaker{% if page.speakers %}s{% endif %}</h3>
    
    {% if page.speaker %}
      {# Single speaker logic #}
    {% endif %}
    
    {% if page.speakers %}
      {% for speaker_id in page.speakers %}
        {# Multiple speakers logic #}
      {% endfor %}
    {% endif %}
  </div>
{% endif %}
```

## Import Script Usage

### Step 1: Fetch Sessionize Data

```bash
# Using provided script
./.scripts/fetch_sessionize.sh

# Or manually
curl -s "https://sessionize.com/api/v2/{event-id}/view/All" -o temp/sessionize-data.json
```

### Step 2: Import Speakers

```bash
ruby .scripts/import_speakers.rb --file temp/sessionize-data.json --event 2026-cph
```

This creates:
- Speaker profile markdown files
- Placeholder images (if network restricted)

### Step 3: Download Actual Images

If images couldn't be downloaded automatically:

```bash
# If you have a zip archive of images
unzip sessionize-profiles.zip -d temp/profiles_raw/

# Convert and copy images
for speaker in temp/profiles_raw/*.jpg; do
  slug=$(basename "$speaker" .jpg)
  convert "$speaker" -quality 85 "src/assets/images/profiles/${slug}.webp"
done
```

### Step 4: Create Talk Entries

Use Python script to generate talks:
```python
import json

with open('temp/sessionize-data.json', 'r') as f:
    data = json.load(f)

# Map speaker IDs to slugs
# Generate talk slugs from titles
# Create talk markdown files
# See full script in .scripts/import_speakers.rb
```

### Step 5: Update Speaker Profiles with Talks

Add `talks:` array to each speaker profile frontmatter with their talk slugs.

### Step 6: Validate

```bash
# Build site
bundle exec rake jekyll:build

# Check links
bundle exec rake proofer:check

# Preview
bundle exec rake jekyll:serve
```

## Common Issues & Solutions

### Issue: Special Characters in Names
**Solution**: The slug generation includes transliteration for common European characters. Extend the transliteration map in the import script if needed.

### Issue: Speaker Without Photo
**Solution**: Create a placeholder image or use a default avatar. The profile will still display correctly.

### Issue: Session with No Speakers
**Solution**: Skip creating a talk entry or create it without speaker reference. Add speaker manually later.

### Issue: Duplicate Slugs
**Solution**: Add a number suffix to the slug (e.g., `john-smith-2`). Update the import script to detect and handle duplicates.

### Issue: Long Talk Titles
**Solution**: The slug generation handles long titles automatically. Verify the generated filename is under 255 characters.

## Validation Checklist

After import, verify:

- [ ] All speaker profiles created in `src/_profiles/`
- [ ] All profile images present in `src/assets/images/profiles/`
- [ ] All talk entries created in `src/_talks/`
- [ ] Speaker profiles include `talks:` array
- [ ] Talk entries include `speaker:` or `speakers:` field
- [ ] Jekyll build succeeds without errors
- [ ] HTML proofer validates all internal links
- [ ] Profile pages display talks correctly
- [ ] Talk pages display speaker(s) correctly
- [ ] All social links functional
- [ ] All images display correctly

## Future Enhancements

Consider adding:
- Topics/tags extraction from Sessionize
- Session time/room information
- Video/recording links after event
- Automated sync process for updates
- Handling of session status (accepted/declined)

## References

- Import script: `.scripts/import_speakers.rb`
- Fetch script: `.scripts/fetch_sessionize.sh`
- Profile layout: `src/_layouts/profile.html`
- Talk layout: `src/_layouts/talk.html`
- Documentation: `docs/SESSIONIZE_IMPORT.md`

## Version History

- **2026-02-10**: Initial documentation created
  - Covers speaker import, talk creation, bidirectional linking
  - Documents layout updates for displaying relationships
  - Includes complete mapping specifications
