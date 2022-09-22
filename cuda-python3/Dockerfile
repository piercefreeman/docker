ARG CUDA_BASE
ARG PYTHON_VERSION

# Install base cuda
FROM nvidia/cuda:${CUDA_BASE}

# Basic Python compilation utilities
RUN apt-get update && \
    apt-get install -y build-essential && \
    apt-get install -y checkinstall && \
    apt-get install -y libreadline-gplv2-dev && \
    apt-get install -y libncursesw5-dev && \
    apt-get install -y libssl-dev && \
    apt-get install -y libsqlite3-dev && \
    apt-get install -y tk-dev && \
    apt-get install -y libgdbm-dev && \
    apt-get install -y libc6-dev && \
    apt-get install -y libbz2-dev && \
    apt-get install -y zlib1g-dev && \
    apt-get install -y openssl && \
    apt-get install -y libffi-dev && \
    apt-get install -y python3-dev && \
    apt-get install -y python3-setuptools && \
    apt-get install -y wget && \
    apt-get install -y liblzma-dev

RUN mkdir /tmp/PythonInstall

RUN cd /tmp/PythonInstall && \
    wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz && \
    tar xvf Python-${PYTHON_VERSION}.tar.xz

RUN cd /tmp/PythonInstall/Python-${PYTHON_VERSION} && \
    ./configure && \
    make altinstall

RUN rm -rf /tmp/PythonInstall

# pip -> pip3.x
RUN ln -s /usr/local/bin/pip${PYTHON_VERSION} /usr/local/bin/pip

# python -> pip3.x
RUN ln -s /usr/local/bin/python${PYTHON_VERSION} /usr/local/bin/python
