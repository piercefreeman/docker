# ubuntu-python3

Built ubuntu LTS versions with modern python installs.

## Installing

Tag conventions are setup as `${ CUDA_VERSION }-${ UBUNTU_VERSION }-${ PYTHON_VERSION }`. Examples:

- `cuda-python3:9.0-base-ubuntu16.04-3.7.7`
- `cuda-python3:11.4.0-base-ubuntu20.04-3.10.7`

This distribution starts with a limited matrix of version numbers that are not intended to be extensive. If you find yourself using a different combination and want it bundled as part of the build process, put up a [PR](https://github.com/piercefreeman/docker/pulls).

```
docker pull piercefreeman/cuda-python3:cuda-python3:9.0-base-ubuntu16.04-3.7.7
```
