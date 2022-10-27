# ubuntu-python3

Forked version of buster-python-slim that provides for ubuntu LTS versions with modern python installs.

## Installing

Tag conventions are setup as `${ UBUNTU_VERSION }-${ PYTHON_VERSION }`. Examples:

- `ubuntu-python3:18.04-3.7.7`

This distribution starts with a limited matrix of version numbers that are not intended to be extensive. If you find yourself using a different combination and want it bundled as part of the build process, put up a [PR](https://github.com/piercefreeman/docker/pulls).

```
docker pull piercefreeman/ubuntu-python3:18.04-3.7.7
```
