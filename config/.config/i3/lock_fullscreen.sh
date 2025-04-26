#!/bin/bash

active_window=$(xprop -root | grep '_NET_ACTIVE_WINDOW(WINDOW)' | awk '{print $5}')
current_brightness=$(cat /tmp/brightness)
if [ "$active_window" != "0x0" ] && xprop -id "$active_window" | grep -q "_NET_WM_STATE_FULLSCREEN"; then
    echo "Window is in fullscreen" > /tmp/lock_log
    exit 0  # Don't lock
else
    i3lock -c 1f1f1f
    echo "locking $current_brightness" > /tmp/lock_log
fi

brightnessctl set $current_brightness
