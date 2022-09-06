FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=America/Los_Angeles

ARG PLAYWRIGHT_VERSION

# === INSTALL Node.js ===

RUN apt-get update && \
    # Install node16
    apt-get install -y curl wget gpg && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    # Feature-parity with node.js base images.
    apt-get install -y --no-install-recommends git openssh-client && \
    npm install -g yarn && \
    # clean apt cache
    rm -rf /var/lib/apt/lists/* && \
    # Create the pwuser
    adduser pwuser

# === BAKE BROWSERS INTO IMAGE ===

ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

# 2. Bake in browsers & deps. We do npm installs in a temporary /ms-playwright-agent directory
#    that is cleared after the browsers are installed. Image consumers are expected to install
#    their own playwright dependency separately.
#
#    Browsers will be downloaded in `/ms-playwright`.
#
#    Note: make sure to set 777 to the registry so that any user can access
#    registry.
RUN mkdir /ms-playwright && \
    mkdir /ms-playwright-agent && \
    cd /ms-playwright-agent && npm init -y && \
    npm i playwright-core@$PLAYWRIGHT_VERSION && \
    npx playwright install chromium --with-deps && rm -rf /var/lib/apt/lists/* && \
    rm -rf /ms-playwright-agent && \
    chmod -R 777 /ms-playwright

# https://stackoverflow.com/questions/50942859/puppeteer-not-running-in-headlessfalse-mode
RUN apt-get update && \
    apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
    libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
    libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
    libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
    ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget \
    xvfb x11vnc x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps libgbm-dev

# Include a default entrypoint that launches a default npm script as the entrypoint
COPY ./entrypoint.sh /entrypoint.sh
COPY ./run_vnc.sh /run_vnc.sh

ENV VNC_PASSWORD "mypassword"

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["run"]
