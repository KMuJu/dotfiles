#!/bin/bash

# EWW="$HOME/apps/eww/target/release/eww"
WIDGET="power_profiles"
CONFIG="$HOME/.config/eww/widgets"
LOGFILE="$HOME/.cache/eww/${WIDGET}_audio_control.log"
source "$CONFIG/screen_utils.sh"

function log {
    echo "$(date): $1" >> "$LOGFILE"
    echo "$(date): $1"
}

log "Running script at $(date)"
log "CONFIG: $CONFIG"

# eww daemon --config "$CONFIG" >> "$LOGFILE" 2>&1

screen=$(x_get_monitor_from_mouse)

eww update sinks_json="${sinks}" --config "$CONFIG" >> "$LOGFILE" 2>&1
eww open power_profiles --toggle --screen $screen --duration "10s" --config "$CONFIG" >> "$LOGFILE" 2>&1

if [[ "$1" == "inspect" ]]; then
    eww inspector --config "$CONFIG" >> "$LOGFILE"
fi
