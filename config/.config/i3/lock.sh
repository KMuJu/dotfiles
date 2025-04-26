#!/bin/bash

# Disable all timers
xidlehook-client --socket /tmp/xidlehook.sock control --action disable

i3lock -n -c 1f1f1f

# Enable all timers
xidlehook-client --socket /tmp/xidlehook.sock control --action enable
