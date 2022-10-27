# cuda-python3

Since the `nvidia-cuda`(https://hub.docker.com/r/nvidia/cuda) base images are linked to a particular Ubuntu LTS, they are bundled with a Python version that is sometimes quite outdated. Some DL accleration libraries are lagging behind in their support for cuda versions but run just fine on the latest Python version. This makes it difficult to use the latest version of Python on a supported cuda configuration. These Docker images extend the base cuda images with non-standard Python distributions in order to utilize the latest language features.

## Installing

Tag conventions are setup as `${ CUDA_VERSION }-${ UBUNTU_VERSION }-${ PYTHON_VERSION }`. Examples:

- `cuda-python3:9.0-base-ubuntu16.04-3.7.7`
- `cuda-python3:11.4.0-base-ubuntu20.04-3.10.7`

This distribution starts with a limited matrix of version numbers that are not intended to be extensive. If you find yourself using a different combination and want it bundled as part of the build process, put up a [PR](https://github.com/piercefreeman/docker/pulls).

```
docker pull piercefreeman/cuda-python3:cuda-python3:9.0-base-ubuntu16.04-3.7.7
```
