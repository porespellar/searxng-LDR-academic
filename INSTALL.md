# Installation Guide

This SearXNG fork is designed to work with [Learning Circuit's Local Deep Research](https://github.com/LearningCircuit/local-deep-research). It serves as a **drop-in replacement** for their Quick Start "Option 1: Docker" - Step 1.

## Quick Start with Local Deep Research

### Step 1: Deploy SearXNG LDR-Academic Fork (replaces Learning Circuit's Step 1)

**Clone and build this academic-focused fork:**

```bash
# Clone this repository
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

**Run SearXNG:**

```bash
docker run -d -p 8080:8080 --name searxng porespellar/searxng-ldr-academic
```

Verify it's running: http://localhost:8080

### Step 2: Deploy Local Deep Research (Learning Circuit's Step 2)

**Continue with Learning Circuit's setup:**

**Pull and run Local Deep Research (Please build your own docker on ARM):**

```bash
docker run -d -p 5000:5000 --name local-deep-research --volume 'deep-research:/data' -e LDR_DATA_DIR=/data localdeepresearch/local-deep-research
```

> **Note:** You will still need to install **Ollama**, **LM Studio**, or some other form of OpenAI compatible endpoint along with your LLM of choice. We recommend **GPT-OSS:20b** or **GPT-OSS:120b**.

Verify it's running: http://localhost:5000

## What This Fork Provides

By using this academic-focused fork instead of the default SearXNG, you get:

✅ **8 Academic search engines** pre-configured (arXiv, Google Scholar, Semantic Scholar, PubMed, etc.)  
✅ **NSFW content removed** - workplace safe  
✅ **Strict safe search** enabled by default  
✅ **Organized categories** for academic research  

## Alternative: Use Pre-built Image (Coming Soon)

Once pushed to Docker Hub, you can skip the build step:

```bash
# Pull and run (replaces clone + build)
docker run -d -p 8080:8080 --name searxng porespellar/searxng-ldr-academic:0.1.0
```

Then continue with Learning Circuit's Step 2 above.

---

For more details, see:
- [Learning Circuit's Full Documentation](https://github.com/LearningCircuit/local-deep-research)
- [This Fork's README](./README.rst)
- [CHANGELOG](./CHANGELOG.md)
