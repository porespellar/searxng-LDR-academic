# Unified Dockerfile for simplified build

# Builder stage
FROM ghcr.io/searxng/base:searxng-builder AS builder

COPY ./requirements.txt ./requirements-server.txt ./

ENV UV_NO_MANAGED_PYTHON="true"
ENV UV_NATIVE_TLS="true"

ARG TIMESTAMP_VENV="0"

RUN --mount=type=cache,id=uv,target=/root/.cache/uv set -eux -o pipefail; \
    export SOURCE_DATE_EPOCH="$TIMESTAMP_VENV"; \
    uv venv; \
    uv pip install --requirements ./requirements.txt --requirements ./requirements-server.txt; \
    uv cache prune --ci; \
    find ./.venv/lib/ -type f -exec strip --strip-unneeded {} + || true; \
    find ./.venv/lib/ -type d -name "__pycache__" -exec rm -rf {} +; \
    find ./.venv/lib/ -type f -name "*.pyc" -delete; \
    python -m compileall -q -f -j 0 --invalidation-mode=unchecked-hash ./.venv/lib/; \
    find ./.venv/lib/python*/site-packages/*.dist-info/ -type f -name "RECORD" -exec sort -t, -k1,1 -o {} {} \;; \
    find ./.venv/ -exec touch -h --date="@$TIMESTAMP_VENV" {} +

COPY ./searx/ ./searx/
RUN sed -i 's/margin-top:26vh/margin:0!important;padding:0!important;display:flex!important;flex-direction:column!important;justify-content:center!important;align-items:center!important;min-height:100vh!important;position:relative!important;margin-top:0/g' ./searx/static/themes/simple/css/searxng-ltr.min.css && \
    sed -i 's/margin-top:26vh/margin:0!important;padding:0!important;display:flex!important;flex-direction:column!important;justify-content:center!important;align-items:center!important;min-height:100vh!important;position:relative!important;margin-top:0/g' ./searx/static/themes/simple/css/searxng-rtl.min.css && \
    sed -i 's/margin-top:6em}/margin-top:0}/g' ./searx/static/themes/simple/css/searxng-ltr.min.css && \
    sed -i 's/margin-top:6em}/margin-top:0}/g' ./searx/static/themes/simple/css/searxng-rtl.min.css
RUN sed -i "s/searxng_extra_version = ''/searxng_extra_version = '-LDR-academic-0.2.0'/g" searx/version.py && \
    echo "GIT_BRANCH = 'main'" >> ./searx/version_frozen.py && \
    echo "GIT_REVISION = 'v0.1.0'" >> ./searx/version_frozen.py

ARG TIMESTAMP_SETTINGS="0"

RUN set -eux -o pipefail; \
    python -m compileall -q -f -j 0 --invalidation-mode=unchecked-hash ./searx/; \
    find ./searx/static/ -type f \
    \( -name "*.html" -o -name "*.css" -o -name "*.js" -o -name "*.svg" \) \
    -exec gzip -9 -k {} + \
    -exec brotli -9 -k {} + \
    -exec gzip --test {}.gz + \
    -exec brotli --test {}.br +; \
    touch -c --date="@$TIMESTAMP_SETTINGS" ./searx/settings.yml

# Dist stage
FROM ghcr.io/searxng/base:searxng AS dist

COPY --chown=977:977 --from=builder /usr/local/searxng/.venv/ ./.venv/
COPY --chown=977:977 --from=builder /usr/local/searxng/searx/ ./searx/
COPY --chown=977:977 ./container/ ./
COPY --chown=977:977 --from=builder /usr/local/searxng/searx/version_frozen.py ./searx/

ARG CREATED="0001-01-01T00:00:00Z"
ARG VERSION="unknown"
ARG VCS_URL="unknown"
ARG VCS_REVISION="unknown"

LABEL org.opencontainers.image.created="$CREATED" \
    org.opencontainers.image.description="SearXNG is a metasearch engine. Users are neither tracked nor profiled." \
    org.opencontainers.image.documentation="https://docs.searxng.org/admin/installation-docker" \
    org.opencontainers.image.licenses="AGPL-3.0-or-later" \
    org.opencontainers.image.revision="$VCS_REVISION" \
    org.opencontainers.image.source="$VCS_URL" \
    org.opencontainers.image.title="SearXNG" \
    org.opencontainers.image.url="https://searxng.org" \
    org.opencontainers.image.version="$VERSION"

ENV SEARXNG_VERSION="$VERSION" \
    SEARXNG_SETTINGS_PATH="$CONFIG_PATH/settings.yml" \
    GRANIAN_PROCESS_NAME="searxng" \
    GRANIAN_INTERFACE="wsgi" \
    GRANIAN_HOST="::" \
    GRANIAN_PORT="8080" \
    GRANIAN_WEBSOCKETS="false" \
    GRANIAN_BLOCKING_THREADS="4" \
    GRANIAN_WORKERS_KILL_TIMEOUT="30s" \
    GRANIAN_BLOCKING_THREADS_IDLE_TIMEOUT="5m"

# "*_PATH" ENVs are defined in base images
VOLUME $CONFIG_PATH
VOLUME $DATA_PATH

EXPOSE 8080

ENTRYPOINT ["/usr/local/searxng/entrypoint.sh"]
