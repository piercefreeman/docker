# headfull-chromium

Package dependencies to run chromium in headfull mode with Playwright.

Key environment variables:

- `APP_PATH`: Working directory for the docker container that houses your node.js executable
- `NODE_EXEC`: The bash command to execute in order to run your control code. Examples include `npm run start` and `node index.js`.
- `VNC_PASSWORD`: Default password for the VNC server that controls the headfull browser.

## Client Code

This deployment could be used in remote control mode, like with [CDPSessions](https://playwright.dev/docs/api/class-browsertype#browser-type-launch-server). However more commonly I've used it by bundling playwright and the browser runtime side-by-side. This has some advantages for chatty connections or frequent connections since it decreases network bandwidth latency.

The recommended execution pattern is therefore to build your npm project and leverage the image's entrypoint.sh file for bootup. We recommend:
- Create a npm project that houses your browser control code
- Build a custom dockerfile that inherits from this base, setting the $APP_PATH env variable to wherever your root npm project is copied over
- Export the $NODE_EXEC environment variable to however you want to launch your node application

See the `test-app` for an example Dockerfile.

Alternatively, if you need a different entrypoint you can use the `/run_vnc.sh` file to manually launch X11 and the VNC.

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

## Screen Control

![MacOS VNC](https://raw.githubusercontent.com/piercefreeman/docker/main/docs/chrome_vnc.png)

We expose a VNC server so you can view and control the Chrome window that Playwright is executing through a regular VNC client. This effectively makes debugging through docker the same as debugging locally. The docker image will expose the VNC server on port `5900`, which can be mounted to any local host port once you launch the container. To try this out we bundle a small test application that showcases some of the business logic. You'll have to build this locally:

```
docker build -t test-headfull-app .
```

Now we can launch the application. Here we set 5910 on the docker host as the VNC tunnel. On Macs you can use the bundled "Screen Sharing" utility to control the browser. The default password is "mypassword". To override, set the `VNC_PASSWORD` env variable.

```
docker run -p 5910:5900 test-headfull-app
```

### Catching SIGTERM / SIGINT in node process

Do you need to listen to SIGTERM / SIGINT signals in your application logic? By default, npm [swallows](https://help.heroku.com/ROG3H81R/why-does-sigterm-handling-not-work-correctly-in-nodejs-with-npm) these signals before they reach the application code. To ensure this works correctly, start your program with `node index.js` or equivalent and not npm.
