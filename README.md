# docker
Monorepo of docker images for ML, data processing, and web crawling. Full README details can be found in the respective project directories.

## [headfull-chromium](./headfull-chromium/)

A full suite of packages to support headfull Chromium execution: font installation, X11 support, and VNC control through an embedded server.

```
docker pull piercefreeman/headfull-chromium:1.25.1
```

## [cuda-python37](./cuda-python37/)

A cuda installation that combines CUDA 9.0 and Python 3.7, which isn't available in the nvidia base image by default.
