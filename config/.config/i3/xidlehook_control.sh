#!/bin/bash

case "$1" in
    lock)
        # Lock the screen
        ~/.config/i3/lock.sh
        ;;
    reset_brightness)
        # Kill the dimming script
        pkill dim-screen2.sh
        brightnessctl set $(cat /tmp/brightness)
        echo "testing"
        ;;
    *)
        echo "Wrong usage"
        exit 1
        ;;
esac
