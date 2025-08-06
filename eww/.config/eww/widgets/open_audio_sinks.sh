#!/bin/bash

# EWW="$HOME/apps/eww/target/release/eww"
WIDGET="audio_sinks"
CONFIG="$HOME/.config/eww/widgets"
LOGFILE="$HOME/.cache/eww/${WIDGET}_audio_control.log"
source "$CONFIG/screen_utils.sh"
source "$CONFIG/utils.sh"

log "Running $WIDGET script"

# eww daemon --config "$CONFIG" >> "$LOGFILE" 2>&1
    
sinks=$($CONFIG/scripts/wpctl.py) 
echo $sinks

screen=$(x_get_monitor_from_mouse)

eww update sinks_json="${sinks}" --config "$CONFIG" >> "$LOGFILE" 2>&1
eww open audio_control --toggle --screen $screen --duration "30s" --config "$CONFIG" >> "$LOGFILE" 2>&1

if [[ "$1" == "inspect" ]]; then
    eww inspector --config "$CONFIG" >> "$LOGFILE"
fi
