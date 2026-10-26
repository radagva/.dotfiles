---
description: Extracts YouTube video metadata: transcript with time marks, and suggested title, description, and tags in Spanish. Use when user says "process video", "get video metadata", "transcript video", "youtube title", "description and tags", or provides a YouTube URL or a local .mp4.
mode: all
---

# YouTube Video Metadata

Process a video and return metadata: transcript with time marks, suggested title, description, and tags.

## Input

Either:

- A YouTube video URL (e.g. `https://www.youtube.com/watch?v=VIDEO_ID`)
- A path to a local `.mp4` file

## Workflow

### Step 1: Get the source

**YouTube URL:** extract the 11-character video ID. Patterns: `watch?v=VIDEO_ID`, `youtu.be/VIDEO_ID`, `/embed/VIDEO_ID`.

**Local mp4:** there is no video ID. Get the transcript from `_transcripts/main.py` instead of Step 3:

1. Edit line 9 of `_transcripts/main.py`: `model.transcribe("<hardcoded filename>")` → your mp4 (absolute path is safest).
2. Run from `_transcripts/`:
   ```bash
   /Users/radagv/Content/_transcripts/.venv/bin/python main.py
   ```
3. Read `_transcripts/transcript_timestamps.txt` (`[H:MM:SS] text` lines).

Whisper is CPU-only (`base` model): multi-GB videos take minutes. Skip Step 2 (yt-dlp) for local files.

### Step 2: Fetch YouTube metadata (YouTube URLs only)

```bash
yt-dlp --dump-json --no-download "https://www.youtube.com/watch?v=VIDEO_ID" > /tmp/video_meta.json
```

Extract `id`, `title`, `description`, `upload_date`, `duration`, `tags`, `categories`, `channel`.

### Step 3: Generate transcript with time marks (YouTube URLs only)

```bash
youtube_transcript_api --languages es --format json VIDEO_ID > /tmp/transcript.json
```

Process into `MM:SS` format (no brackets):

```bash
python3 -c "
import json
with open('/tmp/transcript.json') as f:
    data = json.load(f)
for seg in data[0]:
    mins = int(seg['start'] // 60)
    secs = int(seg['start'] % 60)
    print(f'{mins:02d}:{secs:02d} {seg[\"text\"]}')
"
```

For local mp4s, reuse the Whisper timestamps from `transcript_timestamps.txt` instead.

### Step 4: Determine episode number

Known episodes in playlist `PLT8HWtW5j6_I`:

| EP  | Video ID      | Topic                 |
| --- | ------------- | --------------------- |
| 01  | gQxYELcULuU   | Introduccion          |
| 02  | 0gobP1ccpNg   | Tipos Basicos         |
| 03  | zgjZHxDGQiw   | Record y Unknown      |
| 04  | jmD9AX4XhJc   | Record y Str Literals |
| 05  | qAQ2a1y-n44   | Exclude y Extract     |
| 06  | x1VFQ3-HlqU   | Tipado de Funciones   |
| 07  | oidHkzQdGMg   | Type Assertions       |
| 08  | aJxNfzgHD1w   | (next)                |

For newer episodes, check the existing posts: `ls radagva/src/content/posts/es/typescript_guide_*.md`.

### Step 5: Suggest Title, Description, Tags (Spanish)

Based on transcript and metadata, generate:

- **Title**: `"Curso de Typescript EP{NUMBER}: {Topic}"`
- **Description**: 1-2 sentence summary in Spanish, concise and SEO-friendly
- **Tags**: Always include `Typescript`, `Frontend`, `Backend`, `Serie` + topic-specific tags

## Output Format

```
=== METATAGS (YouTube video keywords, comma-separated) ===

typescript, {keyword1}, {keyword2}, {keyword3}, webdev, softwareengineering, programacionparahumanos, frontend, backend, typescripttutorial, nodejs

=== DESCRIPTION ===

¡Bienvenido al {NÚMERO EN LETRAS} capítulo de nuestra serie sobre TypeScript! {Párrafo introductorio que explica qué se aprenderá en el video, mencionando los conceptos principales con negritas (**concepto**).}

{Segundo párrafo con detalles adicionales sobre lo que se verá.}

📌 Lo que aprenderás en este video:
- {Concepto 1 con negritas en el nombre clave}.
- {Concepto 2 con negritas}.
- {Concepto 3 con negritas}.
- {Mínimo 5-8 puntos, máximo 10}.

⏱️ Marcas de tiempo (Key Moments):
00:00 {Descripción corta del tema}
MM:SS {Descripción corta del tema}
MM:SS {Descripción corta del tema}
...
{Incluir marcas para cada sección principal del video, no para cada línea del transcript}

💻 Repositorio del curso:
https://github.com/radagva/ts-example

🦦 Blog post: https://radagva.dev/posts/{slug}

🔔 ¡Suscríbete al canal para no perderte los próximos capítulos de la serie de TypeScript!

#typescript #returntype #parameters #utilitytypes #typeinference #webdev #softwareengineering #programacionparahumanos #frontend #backend #typescripttutorial #nodejs
```

## Rules

- Never use em dashes (—) anywhere in the output.
- Content language: Spanish (match the video language).
- Base everything on the transcript; do not invent topics the video does not cover.
