#!/bin/bash

wpctl set-default $1

CONFIG="$HOME/.config/eww/audio_control"
LOGFILE="$HOME/.cache/eww/audio_control.log"
sinks=$($CONFIG/scripts/wpctl.py) 

eww update sinks_json="${sinks}" --config "$CONFIG" >> "$LOGFILE" 2>&1

