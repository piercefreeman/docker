# headfull-chromium

Package dependencies to run chromium in headfull mode with playwright.

## Client Code

This deployment could be used in remote control mode, like with [CDPSessions](https://playwright.dev/docs/api/class-browsertype#browser-type-launch-server). However more commonly I've used it by bundling playwright and the browser runtime side-by-side. This has some advantages for chatty connections or frequent connections since it decreases network bandwidth latency.

If so, the recommended execution pattern is to build your npm project and leverage this entrypoint.sh file that keeps the browser image service alive. To do this:
- Create a npm project that houses your browser control code
- Build a custom dockerfile that inherits from this base, setting the $APP_PATH env variable to wherever your root npm project is copied over
- Ensure your ENTRYPOINT is set to [ "/entrypoint.sh" ]

## Running

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
