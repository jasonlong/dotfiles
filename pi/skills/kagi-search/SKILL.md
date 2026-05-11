---
name: kagi-search
description: Web search and content extraction via the Kagi Search API. Use for searching documentation, facts, or current web content. Lightweight, no browser required.
---

# Kagi Search

Web search and content extraction using the official Kagi Search API. No browser required.

## Setup

Requires a Kagi account with API access and API credits.

1. Open https://kagi.com/settings/api
2. Generate an API token.
3. Add it to your shell profile (`~/.profile` or `~/.zprofile` for zsh):
   ```bash
   export KAGI_API_KEY="your-api-token-here"
   ```
4. Install dependencies (run once):
   ```bash
   cd {baseDir}
   npm install
   ```

Kagi Search API calls use paid API credits and may require Search API beta access.

## Search

```bash
{baseDir}/search.js "query"                         # Basic search (5 results)
{baseDir}/search.js "query" -n 10                   # More results
{baseDir}/search.js "query" --content               # Include page content as markdown
{baseDir}/search.js "query" -n 3 --content          # Combined options
```

### Options

- `-n <num>` / `--limit <num>` - Number of search results (default: 5, max: 50)
- `--content` - Fetch and include readable page content as markdown

Kagi account search settings and personalization are inherited by the API.

## Extract Page Content

```bash
{baseDir}/content.js https://example.com/article
```

Fetches a URL and extracts readable content as markdown.

## Output Format

```
--- Result 1 ---
Title: Page Title
Link: https://example.com/page
Published: 2024-09-30T00:00:00Z
Snippet: Description from search results
Content: (if --content flag used)
  Markdown content extracted from the page...

--- Related Searches ---
related search one
related search two
```

## When to Use

- Searching for documentation or API references
- Looking up facts or current information
- Fetching content from specific URLs
- Any task requiring web search without interactive browsing
