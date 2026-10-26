---
description: Generates a bilingual (EN + ES) SEO and a11y friendly blog post in Markdown from a YouTube video URL or local .mp4. Use when user says "generate blog post", "create blog entry", "blog from video".
mode: all
---

# YouTube Blog Entry Generator

Generate complete blog posts (EN + ES) from a video transcript.

## Input

Either:

- A YouTube video URL (e.g. `https://www.youtube.com/watch?v=VIDEO_ID`)
- A path to a local `.mp4` file

## Output

Two Markdown files (paths relative to `radagva/`):

- `src/content/posts/es/{slug}.md` (Spanish)
- `src/content/posts/en/{slug}.md` (English)

Follow `radagva/AGENTS.md` for the frontmatter schema, i18n rules, and run `pnpm build` in `radagva/` before finishing.

## Workflow

### Step 1: Extract Video ID (YouTube URLs only)

Extract the 11-character video ID from the URL.

### Step 2: Fetch Video Metadata (YouTube URLs only)

```bash
yt-dlp --dump-json --no-download "https://www.youtube.com/watch?v=VIDEO_ID" > /tmp/video_meta.json 2>/dev/null
```

Fallback to oEmbed if yt-dlp fails:

```bash
curl -s "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=VIDEO_ID&format=json"
```

### Step 3: Fetch Transcript

**YouTube URL:**

```bash
youtube_transcript_api --languages es --format json VIDEO_ID > /tmp/transcript.json
```

If Spanish unavailable, try English (`--languages en`).

**Local mp4:** there is no video ID yet. Transcribe with `_transcripts/main.py`:

1. Edit line 9 of `_transcripts/main.py`: `model.transcribe("<hardcoded filename>")` → your mp4 (absolute path is safest).
2. Run from `_transcripts/`:
   ```bash
   /Users/radagv/Content/_transcripts/.venv/bin/python main.py
   ```
3. Use `_transcripts/transcript_timestamps.txt` (`[H:MM:SS] text` lines) as the transcript.

Whisper is CPU-only (`base` model): multi-GB videos take minutes.

### Step 4: Determine Episode Number

Check existing posts:

```bash
ls radagva/src/content/posts/es/typescript_guide_*.md
ls radagva/src/content/posts/en/typescript_guide_*.md
```

### Step 5: Generate Blog Posts

Generate both files simultaneously.

## SEO Requirements

- **Title**: Include primary keyword (e.g., "TypeScript", topic name) and episode number
- **Description**: 150-160 characters, include primary keyword naturally
- **Headings**: Use hierarchical heading structure (h1 > h2 > h3)
- **Keywords**: Use topic-related keywords naturally throughout content
- **Internal linking**: Reference previous episodes where relevant
- **Image alt text**: Descriptive alt text for all images

## a11y Requirements

- All images must have meaningful `alt` text (never empty `alt=""`)
- Code blocks must have language identifier (`typescript`)
- Use semantic heading hierarchy (never skip levels)
- External links with `target="_blank"` must have `rel="noopener noreferrer"`
- `<time>` elements with `datetime` attribute for dates
- Lists for structured content (use `<ul>` or `<ol>`)
- Tables for structured data with proper headers

## Content Guidelines

- Generate content in both **Spanish** and **English**
- Follow the transcript closely while polishing for readability
- Extract code examples directly from the transcript
- Create section headings based on topic changes
- Use **bold** for key concepts in introductory paragraphs
- 3-6 content sections depending on video complexity
- Descriptive code comments in the respective language
- Include practical examples from the video
- `status: draft` until user confirms ready to publish
- `publishedAt` must be in UTC

## Punctuation Guidelines

- Do NOT use `—` (em dash). Ever.
- Use `-` (hyphen) to separate contexts or clauses
- Use `""` or `()` to emphasize something
- Example: "TypeScript (un lenguaje de tipos estáticos) es ideal para proyectos grandes"
- Example: "Return Type - una herramienta para inferir tipos"

## TypeScript Code Guidelines

- Do NOT use `any` type. Ever.
- Use `unknown` instead of `any` for untyped values
- Exception: only use `any` if the user explicitly requests it or the video transcript uses it

## Local mp4 note

Without a YouTube video ID, omit `resource:` from the frontmatter and the `## Video` section from the body. Fill them in once the video is uploaded.

## File Structure (Spanish)

```markdown
---
title: "Curso de Typescript EP{NUMBER}: {Topic}"
publishedAt: {YYYY-MM-DDTHH:MM:SS.000Z}
description: {description, 150-160 chars, include keyword}
author: Angel Rada
banner:
  src: ../../../assets/images/typescript_banner.jpeg
  alt: Serie TypeScript
image:
  src: ../../../assets/images/typescript_banner.jpeg
  alt: {Descriptive alt text with keywords}
tags:
  - Typescript
  - {Topic Tag}
  - Frontend
  - Backend
  - Serie
status: draft
authorId: es/angel-rada
resource:
  type: youtube
  src: {VIDEO_ID}
---

## Video

Mira el video completo en YouTube:

[![{Descriptive alt}](https://i3.ytimg.com/vi/{VIDEO_ID}/hqdefault.jpg)](https://www.youtube.com/watch?v={VIDEO_ID}&ref=radagva_blog)

## Introducción

{2-3 paragraphs. Use bold for key concepts. Include primary keyword.}

## {Section Title}

{Descriptive content following transcript}

### {Subsection}

```typescript
// Code example with descriptive comment
const example = "from transcript"
```

## Mejores Prácticas

1. {Practice with keyword}
2. {Practice}
3. {Practice}

## Conclusión

{Summary with keyword}

## Repositorio

💻 Repositorio: https://github.com/radagva/ts-example
```

## File Structure (English)

```markdown
---
title: "TypeScript Guide EP{NUMBER}: {Topic}"
publishedAt: {YYYY-MM-DDTHH:MM:SS.000Z}
description: {description, 150-160 chars, include keyword}
author: Angel Rada
banner:
  src: ../../../assets/images/typescript_banner.jpeg
  alt: TypeScript Series
image:
  src: ../../../assets/images/typescript_banner.jpeg
  alt: {Descriptive alt text with keywords}
tags:
  - Typescript
  - {Topic Tag}
  - Frontend
  - Backend
  - Series
status: draft
authorId: en/angel-rada
resource:
  type: youtube
  src: {VIDEO_ID}
---

## Video

Watch the full video on YouTube:

[![{Descriptive alt}](https://i3.ytimg.com/vi/{VIDEO_ID}/hqdefault.jpg)](https://www.youtube.com/watch?v={VIDEO_ID}&ref=radagva_blog)

## Introduction

{2-3 paragraphs. Use bold for key concepts. Include primary keyword.}

## {Section Title}

{Descriptive content following transcript}

### {Subsection}

```typescript
// Code example with descriptive comment
const example = "from transcript"
```

## Best Practices

1. {Practice with keyword}
2. {Practice}
3. {Practice}

## Conclusion

{Summary with keyword}

## Repository

💻 Repository: https://github.com/radagva/ts-example
```

## Reference Posts

Follow the exact structure of:

- `radagva/src/content/posts/es/typescript_guide_07_type_assertion.md`
- `radagva/src/content/posts/en/typescript_guide_07_type_assertion.md`
