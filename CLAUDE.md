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
blog/index.html     Blog listing
media/index.html    Media listing (talks, podcasts, interviews)
media/videos/       Self-hosted video/audio files
css/style.css       Single stylesheet
robots.txt          AI-crawler permissive
sitemap.xml         All pages
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

### CSS
- Single file: `css/style.css`
- CSS custom properties for all colors/spacing (defined in `:root`)
- Dark mode via `prefers-color-scheme: dark`
- System font stack — no external font requests
- Editorial broadsheet aesthetic: serif body text, sans-serif labels, no border-radius

### AEO
- Every page must have Schema.org JSON-LD in `<script type="application/ld+json">`
- Every page must have `<meta name="description">`, OpenGraph tags, and `<link rel="canonical">`
- Update `sitemap.xml` and `llms.txt` when adding new pages
- Section headings should read as implicit Q&A (e.g., "What does Hunter work on?")
- All content in raw HTML — never behind JS rendering

### Media
- Self-host all media files in `media/videos/` — do not link to external services
- Use HTML5 `<video>` and `<audio>` elements with `controls` and `preload="metadata"`
- URL-safe filenames (lowercase, hyphens, no special characters)

### Deployment
- `.assetsignore` controls what gets excluded from Cloudflare uploads
- Never commit `.env` (contains Cloudflare API token)
- Large media files may hit Cloudflare size limits — monitor deploy output
