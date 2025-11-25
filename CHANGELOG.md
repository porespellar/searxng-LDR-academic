# Changelog

All notable changes to SearXNG LDR-Academic Fork will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [v0.2.0] - 2025-11-25

### Added
- **4 New Academic Search Engines:**
  - **BASE (Bielefeld Academic Search Engine):** Massive index of academic web resources.
  - **OpenAlex:** Open catalog of scholarly works, authors, and institutions.
  - **Wolfram|Alpha (Science):** Computational knowledge engine for math and science.
  - **Library of Congress:** Resources for history, humanities, and visual materials.
- Updated documentation to reflect new engines.

## [0.1.0] - 2025-11-23

### Added
- **Academic category** with 8 research-focused search engines
- Academic subcategories for better organization:
  - General (arXiv, Google Scholar, Semantic Scholar)
  - Life Sciences (PubMed, PDBe)
  - Open Access (OpenAIRE Publications, OpenAIRE Datasets)
  - Publishing (CrossRef)
- "LDR-academic Fork" branding throughout UI
- Comprehensive installation guide (`INSTALL.md`)
- Security audit documentation (Trivy & Grype scans)

### Changed
- Default language set to US English (`en-US`)
- Strict safe search enabled by default
- Updated footer branding to "SearXNG (LDR-academic fork)"
- Updated preferences page header with logo and subtitle

### Removed
- **Categories removed:**
  - Videos
  - Music
  - Files
  - Social Media
  
- **NSFW/inappropriate engines removed:**
  - All adult content engines
  - Torrent/piracy engines (Pirate Bay, KickassTorrents, digbt)
  - All video streaming engines (YouTube, Vimeo, Dailymotion, etc.)
  - All audio/music engines (SoundCloud, Spotify, etc.)
  - All social media engines (Reddit, Twitter, Facebook, etc.)
  - Gambling/casino related engines
  
- **Engine implementation files removed:**
  - `searx/engines/digbt.py`
  - `searx/templates/simple/result_templates/torrent.html`

### Security
- ✅ Security audited with Trivy: 0 critical/high vulnerabilities
- ✅ Security audited with Grype: 0 critical/high vulnerabilities with fixes
- All NSFW content permanently removed from codebase
- Docker image verified secure for production use

### Fixed
- CSS layout issues in main search page
- Branding consistency across all pages (index, preferences, about)

### Technical Details
- Base image: `ghcr.io/searxng/base:searxng`
- Python version: 3.13
- Docker build optimized with multi-stage build
- Minified CSS patched for proper layout

---

## Future Releases

This fork follows a focused release strategy prioritizing academic research needs and workplace safety.

[0.1.0]: https://github.com/porespellar/searxng-LDR-academic/releases/tag/v0.1.0
