#!/bin/bash -e

if [ "$1" = "run" ]; then
    result=1
    while [ $result -ne 0 ]; do
        # Clear out temp files that might be remaining from previous
        # xvfb runs - like https://stackoverflow.com/questions/16726227/xvfb-failed-start-error
        find /tmp -type f -exec rm {} \;

        xvfb-run --server-args="-screen 0 1524x768x24" npm run start

        # holds exit status of last executed command
        result=$?
    done
else
    exec "$@"
fi
