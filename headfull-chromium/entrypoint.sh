#!/bin/bash -e

if [ "$1" = "run" ]; then
    # When running this we likely see a warning:
    # > Xlib:  extension "DPMS" missing on display ":0".
    # This is a known issue. DPMS corresponds to the Display Power Management Signaling extension
    # and is not required for virtual displays
    exec /run_vnc.sh --server-args="-screen 0 1524x768x24" $NODE_EXEC
else
    exec "$@"
fi
