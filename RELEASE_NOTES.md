# Release Notes - v0.2.0

**SearXNG LDR-Academic Fork v0.2.0** - Expanded Academic Engine Support

## 🚀 New Features

### 4 New Academic Engines Added
We have significantly expanded the academic search capabilities by enabling 4 powerful new engines (no API keys required):

1.  **BASE (Bielefeld Academic Search Engine)**
    *   One of the world's most voluminous search engines for academic web resources.
2.  **OpenAlex**
    *   A massive open catalog of scholarly works, authors, and institutions.
3.  **Wolfram|Alpha (Science)**
    *   Computational knowledge engine for mathematics, physics, and scientific data.
4.  **Library of Congress**
    *   Excellent resource for history, humanities, and visual research.

## 📦 Installation

**Clone the repository:**
```bash
git clone https://github.com/porespellar/searxng-LDR-academic.git
```

**Navigate to the directory:**
```bash
cd searxng-LDR-academic
```

**Build the Docker image:**
```bash
docker build -t porespellar/searxng-ldr-academic .
```

**Run the container:**
```bash
docker run -d -p 8080:8080 --name searxng porespellar/searxng-ldr-academic
```

**Access:** http://localhost:8080

> **Tip:** You can adjust search settings, including enabling or disabling specific search engines, by clicking the **Preferences** link on the main page.

## 🔬 Full List of Academic Engines (12 Total)

| Engine | Category | Focus Area |
|--------|----------|------------|
| **BASE** | General | Academic web resources (New!) |
| **OpenAlex** | General | Scholarly catalog (New!) |
| **Wolfram\|Alpha** | General | Computational knowledge (New!) |
| **Library of Congress** | General | History & Humanities (New!) |
| arXiv | General | Physics, Math, CS preprints |
| Google Scholar | General | Comprehensive academic search |
| Semantic Scholar | General | AI-powered research |
| PubMed | Life Sciences | Biomedical literature |
| PDBe | Life Sciences | Protein structures |
| OpenAIRE Publications | Open Access | European research |
| OpenAIRE Datasets | Open Access | Research data |
| CrossRef | Publishing | DOI registry |

## 📝 Full Changelog

See [CHANGELOG.md](./CHANGELOG.md) for detailed changes.
