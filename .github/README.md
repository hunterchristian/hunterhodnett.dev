# hunterhodnett.dev

Personal website for Hunter Hodnett — a static, AEO-optimized portfolio site.

## Stack

- Raw HTML5 + CSS3 (no frameworks, no build step)
- Hosted on Cloudflare Pages
- Auto-deploys from this repo

## Structure

```
index.html          Homepage: hero bio + featured content
blog/index.html     Blog listing page
podcasts/index.html Podcast appearances listing page
css/style.css       Single stylesheet
robots.txt          AI-crawler permissive
sitemap.xml         All pages listed
llms.txt            AI-agent-readable site summary
humans.txt          Attribution file
```

## AEO (Answer Engine Optimization)

This site is built to be maximally understandable by AI agents and search crawlers:

- Semantic HTML5 landmarks and heading hierarchy
- Schema.org JSON-LD structured data on every page
- `llms.txt` for AI agent consumption
- Permissive `robots.txt` welcoming all AI crawlers
- No JavaScript required to render content
- Clean, descriptive meta tags and OpenGraph data

## Development

No build step needed. Open `index.html` in a browser or serve locally:

```sh
npx serve .
```

## Deployment

Connected to Cloudflare Pages for automatic deployment on push to `main`.
