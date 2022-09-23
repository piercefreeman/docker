ARG CUDA_BASE

# Install base cuda
FROM nvidia/cuda:${CUDA_BASE}

ARG PYTHON_VERSION
ARG PYTHON_VERSION_SHORT

# Basic Python compilation utilities
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential \
    checkinstall \
    libncursesw5-dev \
    libssl-dev \
    libsqlite3-dev \
    tk-dev \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev \
    zlib1g-dev \
    openssl \
    libffi-dev \
    python3-dev \
    python3-setuptools \
    wget \
    liblzma-dev

RUN mkdir /tmp/PythonInstall

RUN cd /tmp/PythonInstall && \
    wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz && \
    tar xvf Python-${PYTHON_VERSION}.tar.xz

RUN cd /tmp/PythonInstall/Python-${PYTHON_VERSION} && \
    ./configure && \
    make altinstall

RUN rm -rf /tmp/PythonInstall

# pip -> pip3.x
RUN ln -s /usr/local/bin/pip${PYTHON_VERSION_SHORT} /usr/local/bin/pip

# python -> python3.x
RUN ln -s /usr/local/bin/python${PYTHON_VERSION_SHORT} /usr/local/bin/python
