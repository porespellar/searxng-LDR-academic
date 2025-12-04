# Independent Dockerfile for SearXNG-LDR-Academic
# No dependency on upstream SearXNG base images

# ============================================================================
# Builder Stage - Build dependencies and prepare application
# ============================================================================
FROM python:3.11-slim-bookworm AS builder

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    libssl-dev \
    cargo \
    rustc \
    brotli \
    gzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/local/searxng

# Copy requirements files
COPY ./requirements.txt ./requirements-server.txt ./

# Install uv for faster package installation
RUN pip install --no-cache-dir uv

# Create virtual environment and install Python dependencies
ENV UV_NO_MANAGED_PYTHON="true"
ENV UV_NATIVE_TLS="true"

ARG TIMESTAMP_VENV="0"

RUN set -eux; \
    export SOURCE_DATE_EPOCH="$TIMESTAMP_VENV"; \
    uv venv; \
    uv pip install --requirements ./requirements.txt --requirements ./requirements-server.txt; \
    uv cache prune --ci; \
    find ./.venv/lib/ -type f -exec strip --strip-unneeded {} + 2>/dev/null || true; \
    find ./.venv/lib/ -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true; \
    find ./.venv/lib/ -type f -name "*.pyc" -delete; \
    python -m compileall -q -f -j 0 --invalidation-mode=unchecked-hash ./.venv/lib/; \
    find ./.venv/lib/python*/site-packages/*.dist-info/ -type f -name "RECORD" -exec sort -t, -k1,1 -o {} {} \; 2>/dev/null || true; \
    find ./.venv/ -exec touch -h --date="@$TIMESTAMP_VENV" {} + 2>/dev/null || true

# Copy config files
COPY ./searx/settings.yml /etc/searxng/settings.yml
COPY ./searx/limiter.toml /etc/searxng/limiter.toml

# Copy searx application code
COPY ./searx/ ./searx/

# Apply CSS customizations for centered search interface
RUN sed -i 's/margin-top:26vh/margin:0!important;padding:0!important;display:flex!important;flex-direction:column!important;justify-content:center!important;align-items:center!important;min-height:100vh!important;position:relative!important;margin-top:0/g' ./searx/static/themes/simple/css/searxng-ltr.min.css && \
    sed -i 's/margin-top:26vh/margin:0!important;padding:0!important;display:flex!important;flex-direction:column!important;justify-content:center!important;align-items:center!important;min-height:100vh!important;position:relative!important;margin-top:0/g' ./searx/static/themes/simple/css/searxng-rtl.min.css && \
    sed -i 's/margin-top:6em}/margin-top:0}/g' ./searx/static/themes/simple/css/searxng-ltr.min.css && \
    sed -i 's/margin-top:6em}/margin-top:0}/g' ./searx/static/themes/simple/css/searxng-rtl.min.css

# Set version branding for LDR-academic fork
RUN sed -i "s/searxng_extra_version = ''/searxng_extra_version = '-LDR-academic-0.2.4'/g" searx/version.py && \
    echo "VERSION_STRING = 'v0.2.4'" > ./searx/version_frozen.py && \
    echo "VERSION_TAG = 'v0.2.4'" >> ./searx/version_frozen.py && \
    echo "DOCKER_TAG = '0.2.4-ldr.academic'" >> ./searx/version_frozen.py && \
    echo "GIT_URL = 'https://github.com/porespellar/searxng-LDR-academic'" >> ./searx/version_frozen.py && \
    echo "GIT_BRANCH = 'main'" >> ./searx/version_frozen.py && \
    echo "GIT_REVISION = 'v0.2.4'" >> ./searx/version_frozen.py

ARG TIMESTAMP_SETTINGS="0"

# Compile Python code and compress static assets
RUN set -eux; \
    python -m compileall -q -f -j 0 --invalidation-mode=unchecked-hash ./searx/; \
    find ./searx/static/ -type f \( -name "*.html" -o -name "*.css" -o -name "*.js" -o -name "*.svg" \) -exec gzip -9 -k {} \;; \
    find ./searx/static/ -type f \( -name "*.html" -o -name "*.css" -o -name "*.js" -o -name "*.svg" \) -exec brotli -9 -k {} \;; \
    find ./searx/static/ -type f -name "*.gz" -exec gzip --test {} \;; \
    find ./searx/static/ -type f -name "*.br" -exec brotli --test {} \;; \
    touch -c --date="@$TIMESTAMP_SETTINGS" ./searx/settings.yml

# ============================================================================
# Runtime Stage - Minimal production image
# ============================================================================
FROM python:3.11-slim-bookworm AS dist

# Install runtime dependencies only
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    libxml2 \
    libxslt1.1 \
    openssl \
    ca-certificates \
    gosu \
    && rm -rf /var/lib/apt/lists/*

# Create searxng user and group (UID/GID 977 for compatibility)
RUN groupadd -g 977 searxng && \
    useradd -r -u 977 -g searxng -s /bin/sh -M searxng

# Set working directory
WORKDIR /usr/local/searxng

# Copy virtual environment from builder
COPY --chown=977:977 --from=builder /usr/local/searxng/.venv/ ./.venv/

# Copy application code from builder
COPY --chown=977:977 --from=builder /usr/local/searxng/searx/ ./searx/

# Copy container scripts (entrypoint, etc.)
COPY --chown=977:977 ./container/ ./

# Copy version file
COPY --chown=977:977 --from=builder /usr/local/searxng/searx/version_frozen.py ./searx/

# Copy config files to /etc/searxng
COPY --chown=977:977 ./searx/settings.yml /etc/searxng/settings.yml
COPY --chown=977:977 ./searx/limiter.toml /etc/searxng/limiter.toml

# Set build metadata
ARG CREATED="0001-01-01T00:00:00Z"
ARG VERSION="0.2.4-ldr.academic"
ARG VCS_URL="https://github.com/porespellar/searxng-LDR-academic"
ARG VCS_REVISION="v0.2.4"

# Add OCI labels
LABEL org.opencontainers.image.created="$CREATED" \
    org.opencontainers.image.description="SearXNG-LDR-Academic: Academic research-focused metasearch engine fork" \
    org.opencontainers.image.documentation="https://github.com/porespellar/searxng-LDR-academic" \
    org.opencontainers.image.licenses="AGPL-3.0-or-later" \
    org.opencontainers.image.revision="$VCS_REVISION" \
    org.opencontainers.image.source="$VCS_URL" \
    org.opencontainers.image.title="SearXNG-LDR-Academic" \
    org.opencontainers.image.url="https://github.com/porespellar/searxng-LDR-academic" \
    org.opencontainers.image.version="$VERSION"

# Set environment variables for SearXNG and Granian server
ENV SEARXNG_VERSION="$VERSION" \
    CONFIG_PATH="/etc/searxng" \
    DATA_PATH="/var/lib/searxng" \
    SEARXNG_SETTINGS_PATH="/etc/searxng/settings.yml" \
    GRANIAN_PROCESS_NAME="searxng" \
    GRANIAN_INTERFACE="wsgi" \
    GRANIAN_HOST="::" \
    GRANIAN_PORT="8080" \
    GRANIAN_WEBSOCKETS="false" \
    GRANIAN_BLOCKING_THREADS="4" \
    GRANIAN_WORKERS_KILL_TIMEOUT="30s" \
    GRANIAN_BLOCKING_THREADS_IDLE_TIMEOUT="5m"

# Create volume mount points
VOLUME /etc/searxng
VOLUME /var/lib/searxng

# Expose SearXNG port
EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["/usr/local/searxng/entrypoint.sh"]
