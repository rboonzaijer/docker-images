ARG FROM_IMAGE=python:3.14-slim
FROM ${FROM_IMAGE}

# Avoid interactive prompts and speed up installs
ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1

# System deps for some mkdocs plugins (e.g. minify, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Install mkdocs + plugins
RUN pip install --upgrade pip && \
    pip install \
      mkdocs \
      mkdocs-material \
      mkdocs-autolinks-plugin \
      mkdocs-awesome-nav \
      mkdocs-minify-html-plugin \
      mkdocs-markdownextradata-plugin \
      mkdocs-macros-plugin \
      mkdocs-redirects

# Create a non-root user (optional but nice for CI)
RUN useradd -m mkdocs
USER mkdocs
WORKDIR /docs

# Default command: show mkdocs version
CMD ["mkdocs", "--version"]
