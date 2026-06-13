# syntax=docker/dockerfile:1
#
# Personal developer workspace:
# Ubuntu 24.04 + pyenv + Poetry + Node.js + Claude Code CLI
#
# Build args let you bump versions without editing the file:
#   docker build --build-arg PYTHON_VERSION=3.14.6 -t claude-dev-workspace .

FROM ubuntu:24.04

ARG PYTHON_VERSION=3.13.14
ARG NODE_MAJOR=24
ARG CLAUDE_CODE_VERSION=latest

ENV DEBIAN_FRONTEND=noninteractive

# Base tooling + pyenv build dependencies
# (the lib*-dev packages are required to compile CPython from source)
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        less \
        libbz2-dev \
        libffi-dev \
        liblzma-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libxmlsec1-dev \
        nano \
        openssh-client \
        tk-dev \
        unzip \
        xz-utils \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Node.js + npm (NodeSource, Active LTS line)
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# pyenv + a default Python (compiled from source, parallelized)
ENV PYENV_ROOT=/root/.pyenv
ENV PATH=${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}
RUN git clone --depth 1 https://github.com/pyenv/pyenv.git ${PYENV_ROOT} \
    && MAKE_OPTS="-j$(nproc)" pyenv install ${PYTHON_VERSION} \
    && pyenv global ${PYTHON_VERSION} \
    && echo 'eval "$(pyenv init -)"' >> /root/.bashrc

# Poetry (official installer, isolated in /opt/poetry, uses pyenv's Python)
# virtualenvs.in-project keeps .venv inside the project dir, so virtualenvs
# survive container restarts via the /workspace volume.
ENV POETRY_HOME=/opt/poetry
ENV PATH=${POETRY_HOME}/bin:${PATH}
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && poetry config virtualenvs.in-project true

# Claude Code CLI
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}

# Keep ALL Claude Code state (config, credentials from `claude login`,
# and ~/.claude.json) under one directory so a single named volume persists it.
ENV CLAUDE_CONFIG_DIR=/root/.claude
RUN mkdir -p /root/.claude
# Orchestrator config — auto-loaded by Claude Code as the global CLAUDE.md
COPY CLAUDE.md /root/.claude/CLAUDE.md
# Specialist agent definitions — lazy-loaded by the orchestrator as needed
COPY agents/ /root/.claude/agents/
# Grant all tool permissions so Claude never prompts for approval inside the container
COPY settings.json /root/.claude/settings.json

# Git/SSH quality of life:
# - pre-trust common git hosts so the first clone doesn't prompt
# - safe.directory '*': /workspace is a volume, file ownership may not match
RUN echo 'export TERM=xterm-256color' >> /root/.bashrc \
    && echo 'printf "\e[?1000l\e[?1002l\e[?1003l\e[?1006l"' >> /root/.bashrc \
    && echo 'trap "printf \"\e[?1000l\e[?1002l\e[?1003l\e[?1006l\"" EXIT' >> /root/.bashrc

RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh \
    && ssh-keyscan github.com gitlab.com bitbucket.org > /root/.ssh/known_hosts 2>/dev/null \
    && git config --global safe.directory '*'

WORKDIR /workspace
VOLUME /workspace

CMD ["bash"]
