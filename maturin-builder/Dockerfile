ARG PYTHON_VERSION

FROM --platform=$BUILDPLATFORM python:${PYTHON_VERSION}-slim as server-hooks-builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends pipx nodejs

ENV PATH="/root/.local/bin:${PATH}"

RUN pipx install poetry

# Install rust to compile wheels
RUN apt-get update && apt-get install -y curl build-essential
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

# Install golang to compile rust dependencies
ENV GOLANG_VERSION 1.22.2
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    # clang for go compilation
    libclang-dev \
    && rm -rf /var/lib/apt/lists/*

ARG TARGETARCH

# Download and install Go depending on the current architecture
RUN if [ "$TARGETARCH" = "amd64" ]; then \
    SUFFIX="amd64"; \
    GOARCH="amd64"; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
    SUFFIX="arm64"; \
    GOARCH="arm64"; \
    else \
    echo "Unsupported architecture: $TARGETARCH"; \
    exit 1; \
    fi && \
    curl -L "https://golang.org/dl/go${GOLANG_VERSION}.linux-${SUFFIX}.tar.gz" -o "go${GOLANG_VERSION}.linux-${SUFFIX}.tar.gz" && \
    tar -C /usr/local -xzf "go${GOLANG_VERSION}.linux-${SUFFIX}.tar.gz" && \
    rm "go${GOLANG_VERSION}.linux-${SUFFIX}.tar.gz"

# Set GOARCH environment variable
ENV GOARCH=${GOARCH}
