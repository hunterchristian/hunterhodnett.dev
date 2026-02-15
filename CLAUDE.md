# CLAUDE.md — hunterhodnett.dev

## Project Overview
Personal website for Hunter Hodnett. Static HTML/CSS site deployed on Cloudflare Workers. Primary goal is **Answer Engine Optimization (AEO)** — maximizing scrapability by AI agents and bots.

## Stack
- Raw HTML/CSS — no build step, no JavaScript frameworks
- Cloudflare Workers with static assets (`wrangler deploy`)
- Domain: hunterhodnett.ai

## File Structure
```
index.html          Homepage (hero bio, featured content)
index.md            Homepage content in Markdown (for LLMs)
blog/index.html     Blog listing
blog/index.md       Blog content in Markdown (for LLMs)
media/index.html    Media listing (talks, podcasts, interviews)
media/index.md      Media content in Markdown (for LLMs)
media/videos/       Self-hosted video/audio files
css/style.css       Single stylesheet
robots.txt          AI-crawler permissive
sitemap.xml         All pages (HTML + Markdown)
llms.txt            AI-agent-readable site summary
humans.txt          Attribution
wrangler.jsonc      Cloudflare Workers config
.assetsignore       Files excluded from Cloudflare deploy
dev.sh              Local dev server (port 3333)
```

## Development
- Run `./dev.sh` to start local server on port 3333
- Deploy: `source .env && npx wrangler deploy`
- No build step — Cloudflare serves files directly from the repo root

## Rules

### HTML
- Semantic HTML5: `<main>`, `<nav>`, `<article>`, `<section>`, `<header>`, `<footer>`
- Single `<h1>` per page, logical heading hierarchy
- `<time datetime="...">` for all dates
- Descriptive link text (no "click here")
- No inline styles — all styling in css/style.css
- No JavaScript unless absolutely necessary — content must be visible without JS

### Brand & Visual Style
The site's aesthetic is a **1920s editorial broadsheet** — think the front page of a golden-age newspaper reimagined for the web. The tone is warm, approachable, and authoritative.

- **Typography**: Georgia serif for body and headlines, Helvetica/Arial sans-serif for small labels, section headers, and navigation. System font stack only — no external font requests.
- **Color palette**: Warm parchment background (`#FAF9F5` light / `#0E0E0D` dark), muted gold accents (`#8C714A` light / `#C9A86C` dark), ink-dark text. All colors defined as CSS custom properties in `:root`.
- **Layout**: Centered single-column, narrow measure (`680px` max-width). Generous whitespace. Ruled lines (thin `border-top`) separate sections like a broadsheet column.
- **Details**: No border-radius anywhere. Uppercase small-caps for section headers, navigation, and datelines (letter-spaced, tiny font). Italic serif for subtitles and deck lines. Links use gold underline (`text-decoration-color: var(--color-accent)`).
- **Hero structure**: Italic deck headline (tagline) > small-caps role subtitle > small-caps dateline in gold (location) > bio paragraphs. The dateline ("Greer, South Carolina") is a proud, prominent element — never bury the location in body text.
- **Expertise section**: Grouped competencies using `<dl>` with gold category labels (`<dt>`) and pill-tag lists (`<dd>`). Lead with business capabilities (Platform & Product), then AI, Infrastructure, Stack. This is a founder profile, not a job portfolio — emphasize what Hunter builds, not what he "knows."
- **Tone of voice**: First-person "I" is fine in taglines and short copy. Body text is third-person and factual. Friendly, not corporate. Write like a well-edited feature profile, not a résumé. Hunter is a founder and businessman first — the site establishes authority, not employment availability.

### CSS
- Single file: `css/style.css`
- CSS custom properties for all colors/spacing (defined in `:root`)
- Dark mode via `prefers-color-scheme: dark`
- System font stack — no external font requests

### AEO
- Every page must have Schema.org JSON-LD in `<script type="application/ld+json">`
- Every page must have `<meta name="description">`, OpenGraph tags, and `<link rel="canonical">`
- Update `sitemap.xml` and `llms.txt` when adding new pages
- Every HTML page has a matching `.md` file (e.g., `index.html` → `index.md`) with the same content in clean Markdown for LLM consumption
- When adding or updating an HTML page, always update its `.md` counterpart
- Section headings should read as implicit Q&A (e.g., "What does Hunter work on?")
- All content in raw HTML — never behind JS rendering

### Media
- Media files (video/audio) are stored in **Cloudflare R2** bucket `hunterhodnett-media`
- Public URL base: `https://pub-b8df2807b9d74c259ff0f7ee5d4eb1a3.r2.dev/`
- Files are uploaded with path prefix `media/videos/` (e.g., `media/videos/filename.mp4`)
- Local copies live in `media/videos/` for development but are **excluded from Cloudflare Workers deploy** via `.assetsignore`
- All `<video>` and `<audio>` `src` attributes and JSON-LD `contentUrl`/`url` values must point to the R2 public URL
- Use HTML5 `<video>` and `<audio>` elements with `controls` and `preload="metadata"`
- URL-safe filenames (lowercase, hyphens, no special characters)
- **Uploading new media**: Files under 300MB can use `wrangler r2 object put`. Files over 300MB require AWS CLI with S3-compatible multipart upload (see below).

### Deployment
- **Custom domain**: `hunterhodnett.ai` — registered through Cloudflare, served as a Worker custom domain
- **Personal Cloudflare account** (hchodnet@gmail.com) — account ID `88af7e46e0143c6510c9d7b3d09161d9`
- `wrangler.jsonc` has `account_id` pinned to the personal account and a `routes` entry for the custom domain
- `.env` contains `CLOUDFLARE_API_TOKEN` for the personal account — never commit this file
- **Important**: The shell may have Chipp Cloudflare env vars (`CLOUDFLARE_API_KEY`, `CLOUDFLARE_EMAIL`) that override the API token. When running wrangler, unset those first: `unset CLOUDFLARE_API_KEY && unset CLOUDFLARE_EMAIL && unset CLOUDFLARE_ZONE_ID`
- Deploy: `unset CLOUDFLARE_API_KEY && unset CLOUDFLARE_EMAIL && unset CLOUDFLARE_ZONE_ID && source .env && npx wrangler deploy`
- `.assetsignore` excludes `media/videos/` (served from R2 instead)
- R2 S3 credentials are in `.env` (`R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`, `R2_ENDPOINT`)
- **Upload large files to R2**: `AWS_ACCESS_KEY_ID=$R2_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$R2_SECRET_ACCESS_KEY aws s3 cp <file> s3://hunterhodnett-media/<path> --endpoint-url $R2_ENDPOINT`
