# Cruise Personal Website

Site title: **Born Not Knowing**

This is Cruise Cao's personal learning archive: a quiet public notebook for engineering, English, markets, music, projects, and clearer thinking. It is built from AstroPaper and kept intentionally static so publishing notes stays simple.

Core line:

> Born not knowing. Learning ever since.

## Stack

- Astro
- AstroPaper
- TypeScript
- Markdown / MDX content
- Tailwind CSS through the template
- Static site generation
- RSS, sitemap, dark mode, tags, pagination, and Pagefind search

## Local Commands

This repository uses pnpm.

```bash
pnpm install
pnpm dev
pnpm build
pnpm preview
```

If pnpm is not installed globally, install it with Corepack or use a local pnpm binary. The production build command for deployment is:

```bash
pnpm build
```

The output directory is:

```bash
dist
```

## Content Categories

- Engineering
- English
- Markets
- Music
- Projects
- Reflections

## Add a New Note

Create a Markdown or MDX file in `src/content/posts/`.

Use this frontmatter shape:

```yaml
---
title: Your Note Title
description: A short excerpt for lists, RSS, and SEO.
pubDatetime: 2026-05-26T09:00:00+08:00
draft: false
category: Reflections
tags:
  - learning
  - notes
---
```

Valid categories are `Engineering`, `English`, `Markets`, `Music`, `Projects`, and `Reflections`.

Published notes appear under `/notes`, in RSS, in search, and in the generated tag pages.

## Markets Disclaimer

Markets content is a personal learning journal, not financial advice. Nothing here is a recommendation to buy, sell, or hold any investment product.

Markets notes should use study language:

- "I am studying..."
- "My current understanding is..."
- "The risk I may be underestimating is..."
- "This is a note to myself..."

Avoid recommendation language, price targets, claims of guaranteed returns, referral links, and brokerage promotions.

## Cloudflare Pages Deployment

1. Push this repository to GitHub.
2. Open the Cloudflare Dashboard.
3. Go to Workers & Pages.
4. Create an application.
5. Connect the GitHub repository.
6. Set Production branch to `main`.
7. Set Build command to `pnpm build`.
8. Set Output directory to `dist`.
9. Save and deploy.
10. Add a custom domain later.

No Cloudflare adapter is needed for V1 because this is a static site.

## Monthly Maintenance

- Publish one learning note per week.
- Publish one markets study note per month.
- Review `/now` monthly.
- Review old notes instead of endlessly redesigning the site.
