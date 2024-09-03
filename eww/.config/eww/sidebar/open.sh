#!/bin/bash

EWW="$HOME/apps/eww/target/release/eww"
CONFIG="$HOME/.config/eww/sidebar"
LOGFILE="$HOME/sidebar_script.log"

echo "Running script at $(date)" >> "$LOGFILE"
echo "EWW: $EWW" >> "$LOGFILE"
echo "CONFIG: $CONFIG" >> "$LOGFILE"

RUNNING="$CONFIG/running"

$EWW daemon --config "$CONFIG" >> "$LOGFILE" 2>&1

if [ -f "$RUNNING" ] && [ "$(cat "$RUNNING")" == "R" ]; then
    $EWW close sidebar --config "$CONFIG" >> "$LOGFILE" 2>&1
    echo "" > "$RUNNING"
    echo "Closing" >> "$LOGFILE"
else
    $EWW open sidebar --config "$CONFIG" >> "$LOGFILE" 2>&1
    echo "R" > "$RUNNING"
    echo "Running" >> "$LOGFILE"
fi
