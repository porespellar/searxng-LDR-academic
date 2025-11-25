.. SPDX-License-Identifier: AGPL-3.0-or-later

.. figure:: https://raw.githubusercontent.com/searxng/searxng/master/client/simple/src/brand/searxng.svg
   :target: https://github.com/porespellar/searxng-LDR-academic
   :alt: SearXNG
   :width: 400px
   :align: center

SearXNG LDR-Academic Fork
==========================

A specialized academic research fork of SearXNG designed as a **drop-in replacement** for `Learning Circuit's Local Deep Research <https://github.com/LearningCircuit/local-deep-research>`_. This fork is optimized for professional and academic workplace environments, with NSFW content removed and a focus on scholarly search engines.

.. image:: https://img.shields.io/badge/version-0.1.0-blue?style=flat-square
   :alt: Version 0.1.0

.. image:: https://img.shields.io/github/license/searxng/searxng?style=flat-square&label=license&color=3050ff
   :target: https://github.com/searxng/searxng/blob/master/LICENSE
   :alt: License AGPL-3.0

Overview
========

This is a curated fork of SearXNG designed specifically for academic research and professional workplace environments. It removes NSFW content, focuses on academic search engines, and provides a clean, distraction-free search experience.

Key Features
============

**Academic-First Search**
  - Dedicated "Academic" category with 8 research-focused search engines
  - Organized subcategories: General, Life Sciences, Open Access, Publishing
  - Includes arXiv, Google Scholar, Semantic Scholar, PubMed, CrossRef, OpenAIRE, and PDBe

**Workplace Safe**
  - All NSFW, torrent, and piracy engines removed
  - Videos, music, files, and social media categories disabled
  - Strict safe search enabled by default

**Privacy & Security**
  - No user tracking or profiling
  - Security audited (using Trivy and Grype)
  - AGPL-3.0 licensed

**Clean Interface**
  - "LDR-academic Fork" branding throughout
  - Professional appearance suitable for academic institutions
  - US English as default language

Quick Start
===========

See `INSTALL.md <./INSTALL.md>`_ for detailed installation instructions.

Docker Quick Start::

    # Clone the repository
    git clone https://github.com/porespellar/searxng-LDR-academic.git
    cd searxng-LDR-academic

    # Build
    docker build -t porespellar/searxng-ldr-academic .

    # Run
    docker run -d -p 8080:8080 --name searxng porespellar/searxng-ldr-academic

Then visit http://localhost:8080

Integration with Local Deep Research
======================================

This fork is designed as a **drop-in replacement** for Step 1 in `Local Deep Research <https://github.com/LearningCircuit/local-deep-research>`_'s Quick Start (Option 1: Docker).

**Step 1: Deploy this academic fork** (replaces their default SearXNG)::

    # Clone and build this repository
    git clone https://github.com/porespellar/searxng-LDR-academic.git
    cd searxng-LDR-academic
    docker build -t porespellar/searxng-ldr-academic .

    # Run SearXNG
    docker run -d -p 8080:8080 --name searxng porespellar/searxng-ldr-academic

**Step 2: Deploy Local Deep Research** (Learning Circuit's Step 2)::

    # Run Local Deep Research
    docker run -d -p 5000:5000 --name local-deep-research --volume 'deep-research:/data' -e LDR_DATA_DIR=/data localdeepresearch/local-deep-research

Verify both are running:
  - SearXNG: http://localhost:8080
  - Local Deep Research: http://localhost:5000

See `INSTALL.md <./INSTALL.md>`_ for detailed instructions.

Academic Search Engines
========================

**General Research (3 engines)**
  - arXiv - Physics, math, computer science preprints
  - Google Scholar - Comprehensive academic search
  - Semantic Scholar - AI-powered research papers

**Life Sciences (2 engines)**
  - PubMed - Biomedical literature database
  - PDBe - Protein Data Bank Europe

**Open Access (2 engines)**
  - OpenAIRE Publications - European open research
  - OpenAIRE Datasets - Research data repository

**Publishing (1 engine)**
  - CrossRef - DOI registry with 140M+ scholarly records

Differences from Upstream SearXNG
==================================

**Removed Categories:**
  - Videos
  - Music  
  - Files
  - Social Media

**Removed Engines:**
  - All NSFW/adult content engines
  - Torrent/piracy engines (Pirate Bay, KickassTorrents, etc.)
  - Gambling/casino engines
  - Video/audio streaming engines
  - Social media search engines

**Added Features:**
  - Academic category with subcategories
  - 8 academic search engines enabled by default
  - Strict safe search enabled
  - US English default language


Contributing
============

This is a specialized fork maintained for academic research purposes. For contributions to the upstream SearXNG project, see the `official SearXNG repository <https://github.com/searxng/searxng>`_.

License
=======

This project is licensed under the GNU Affero General Public License (AGPL-3.0).
See `LICENSE <./LICENSE>`_ for more details.

Acknowledgments
===============

Built on `SearXNG <https://github.com/searxng/searxng>`_ - a privacy-respecting metasearch engine.

Disclaimer
==========

**No Affiliation**

This project (porespellar/searxng-LDR-academic) is an independent fork and is **not affiliated with, endorsed by, or supported by** the SearXNG project or Learning Circuit. The maintainer (porespellar) has no official relationship with either organization.

**No Warranty**

This software is provided "AS IS", WITHOUT WARRANTY OF ANY KIND, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and noninfringement. The entire risk as to the quality and performance of the software is with you.

**Use At Your Own Risk**

In no event shall the authors, copyright holders, or contributors be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.

**Limitation of Liability**

To the maximum extent permitted by applicable law, in no event will porespellar or any contributors be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses resulting from:

  - Your use or inability to use the software
  - Any unauthorized access to or use of our servers and/or any personal information stored therein
  - Any bugs, viruses, trojan horses, or the like that may be transmitted to or through the software
  - Any errors or omissions in any content or for any loss or damage incurred as a result of the use of any content posted, emailed, transmitted, or otherwise made available through the software

**License Terms**

This software is licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See the `LICENSE <./LICENSE>`_ file for full terms, which include additional warranty disclaimers and limitations of liability.

**Third-Party Services**

This software integrates with third-party search engines and services. The maintainer is not responsible for the availability, accuracy, or content provided by these external services.

**User Responsibility**

By using this software, you acknowledge that you have read this disclaimer, understand it, and agree to be bound by its terms. You are solely responsible for determining the appropriateness of using this software and assume all risks associated with its use.
