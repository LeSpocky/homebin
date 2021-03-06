#!/bin/bash
#
# See: https://unix.stackexchange.com/a/225496/50007
# See: https://gist.github.com/JonathonReinhart/573694d541dc2108f7629aaa615cef3b
#

for f in /sys/class/net/*; do
    dev=$(basename "$f")
    driver=$(readlink "$f/device/driver/module")
    if [ "$driver" ]; then
        driver=$(basename "$driver")
    fi
    addr=$(cat "$f/address")
    operstate=$(cat "$f/operstate")
    printf "%16s [%s]: %10s (%s)\n" "$dev" "$addr" "$driver" "$operstate"
done
