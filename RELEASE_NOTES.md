# Release Notes - v0.1.0

**SearXNG LDR-Academic Fork v0.1.0** - First Official Release

## 🎓 Academic Research Search Engine

A specialized fork of SearXNG designed for academic research and professional environments, with NSFW content removed and focus on scholarly search.

## ✨ Highlights

### Academic-First Design
- **8 Academic Search Engines** enabled by default
- Organized into 4 subcategories: General, Life Sciences, Open Access, Publishing
- Includes arXiv, Google Scholar, Semantic Scholar, PubMed, CrossRef, OpenAIRE, PDBe

### Workplace Safe
- ✅ All NSFW/adult content removed
- ✅ No torrent/piracy engines
- ✅ No social media or entertainment engines
- ✅ Strict safe search enabled by default

### Security Verified
- ✅ **0 critical vulnerabilities** (Trivy scan)
- ✅ **0 high vulnerabilities** (Grype scan)
- ✅ Production-ready Docker image

## 📦 Installation

```bash
# Clone the repository
git clone https://github.com/porespellar/searxng-LDR-academic.git
cd searxng-LDR-academic

# Build
docker build -t porespellar/searxng-ldr-academic .

# Run
docker run -d -p 8080:8080 --name searxng porespellar/searxng-ldr-academic
```

Visit http://localhost:8080

## 🔬 Academic Search Engines

| Engine | Category | Focus Area |
|--------|----------|------------|
| arXiv | General | Physics, Math, CS preprints |
| Google Scholar | General | Comprehensive academic search |
| Semantic Scholar | General | AI-powered research |
| PubMed | Life Sciences | Biomedical literature |
| PDBe | Life Sciences | Protein structures |
| OpenAIRE Publications | Open Access | European research |
| OpenAIRE Datasets | Open Access | Research data |
| CrossRef | Publishing | DOI registry (140M+ records) |

## 🔄 Integration

Designed to work with [Local Deep Research](https://github.com/localdeepresearch/local-deep-research):

```bash
# Run SearXNG
docker run -d -p 8080:8080 --name searxng porespellar/searxng-ldr-academic

# Run LDR
docker run -d -p 5000:5000 --network host \
  --name local-deep-research \
  --volume 'deep-research:/data' \
  -e LDR_DATA_DIR=/data \
  localdeepresearch/local-deep-research
```

## 🗑️ Removed Content

**Categories:** Videos, Music, Files, Social Media  
**Engines:** 50+ inappropriate engines removed including all torrent, NSFW, gambling, and social media engines

## 📝 Full Changelog

See [CHANGELOG.md](./CHANGELOG.md) for detailed changes.

## 📄 License

AGPL-3.0 - Same as upstream SearXNG

## 🙏 Acknowledgments

Built on [SearXNG](https://github.com/searxng/searxng) - a privacy-respecting metasearch engine.

---

**Docker Image:** `porespellar/searxng-ldr-academic:0.1.0`  
**Documentation:** See [README.rst](./README.rst) and [INSTALL.md](./INSTALL.md)  
**Security:** Verified clean via Trivy & Grype scans
