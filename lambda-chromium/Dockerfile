# Base image with Node.js
FROM ubuntu:22.04 AS builder-base

# Common environment variables
# NPM_CONFIG_CACHE: Required for Node runtimes which use npm@8.6.0+ because
# by default npm writes logs under /home/.npm and Lambda fs is read-only
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=America/Los_Angeles \
    PLAYWRIGHT_BROWSERS_PATH=/ms-playwright \
    NPM_CONFIG_CACHE=/tmp/.npm

# Install Node.js, curl, wget, git, and ssh
RUN apt-get update && \
    apt-get install -y curl wget gpg && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get install -y --no-install-recommends git openssh-client && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

# Stage for playwright dependencies
FROM builder-base AS playwright-base

ARG PLAYWRIGHT_VERSION

# Install Playwright and browsers
RUN mkdir /ms-playwright && \
    mkdir /ms-playwright-agent && \
    cd /ms-playwright-agent && npm init -y && \
    npm i playwright-core@$PLAYWRIGHT_VERSION && \
    npx playwright install chromium --with-deps && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /ms-playwright-agent

# Stage for AWS Lambda dependencies
FROM builder-base AS lambda-base

# Install build dependencies for the AWS Lambda RIC
RUN apt-get update && \
    apt-get install -y \
    g++ \
    make \
    cmake \
    unzip \
    libcurl4-openssl-dev \
    autoconf \
    automake \
    libtool && \
    npm install --global --loglevel verbose aws-lambda-ric && \
    rm -rf /var/lib/apt/lists/*

# Final stage
FROM builder-base

ARG FUNCTION_DIR="/function"

WORKDIR ${FUNCTION_DIR}

# Copy relevant files from previous stages
COPY --from=playwright-base ${PLAYWRIGHT_BROWSERS_PATH} ${PLAYWRIGHT_BROWSERS_PATH}
COPY --from=lambda-base /usr/lib/node_modules/aws-lambda-ric /usr/lib/node_modules/aws-lambda-ric

# Additional dependencies for running browsers
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
    libexpat1 libfontconfig1 libgcc1 libgdk-pixbuf2.0-0 libglib2.0-0 \
    libgtk-3-0 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 \
    libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 \
    libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 \
    lsb-release xdg-utils wget libgbm-dev && \
    rm -rf /var/lib/apt/lists/*

# Set runtime interface client as default command for the container runtime
ENTRYPOINT [ "node", "/usr/lib/node_modules/aws-lambda-ric/bin/index.mjs" ]
