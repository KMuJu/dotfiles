#!/bin/bash

# EWW="$HOME/apps/eww/target/release/eww"
CONFIG="$HOME/.config/eww/open_close_template"
LOGFILE="$HOME/.eww_script.log"

function log {
    echo "$(date): $1" >> "$LOGFILE"
    echo "$(date): $1"
}

log "Running script at $(date)"
log "CONFIG: $CONFIG"

RUNNING="$CONFIG/running"

eww daemon --config "$CONFIG" >> "$LOGFILE" 2>&1

if [ -f "$RUNNING" ] && [ "$(cat "$RUNNING")" == "R" ]; then
    eww close open_close --config "$CONFIG" >> "$LOGFILE" 2>&1
    echo "" > "$RUNNING"
    log "Closing"
else
    eww open open_close --config "$CONFIG" >> "$LOGFILE" 2>&1
    echo "R" > "$RUNNING"
    log "Running"
fi
