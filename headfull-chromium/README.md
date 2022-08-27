# headfull-chromium

Package dependencies to run chromium in headfull mode with playwright.

Launching in docker runs within the host namespace by default. For additional security during webcrawling we recommend launching as a [separate user](https://playwright.dev/docs/docker). For convenience we include a copy of the latest seccomp profile here, sourced from the original [repo](https://github.com/microsoft/playwright/blob/main/utils/docker/seccomp_profile.json).

Incorporating this security preference will depend on your method of launching this docker image.

docker CLI:
```
docker run -it --rm --ipc=host --user pwuser --security-opt seccomp=seccomp_profile.json {image} /bin/bash
```

docker-compose.yml:
```
version: '3.9'
services:
  example:
    image: {image}
    security_opt:
      - seccomp:seccomp_profile.json
    ipc: host
    user: pwuser
```
