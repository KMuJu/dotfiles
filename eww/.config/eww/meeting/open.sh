#!/bin/bash

EWW="$HOME/apps/eww/target/release/eww"
CONFIG="$HOME/.config/eww/meeting"
LOGFILE="$HOME/eww_script.log"

echo "Running script at $(date)" >> "$LOGFILE"
echo "EWW: $EWW" >> "$LOGFILE"
echo "CONFIG: $CONFIG" >> "$LOGFILE"
echo "PATH: $PATH" >> "$LOGFILE"

RUNNING="$CONFIG/running"

$EWW daemon --config "$CONFIG" >> "$LOGFILE" 2>&1

if [ -f "$RUNNING" ] && [ "$(cat "$RUNNING")" == "R" ]; then
    $EWW close meeting --config "$CONFIG" >> "$LOGFILE" 2>&1
    echo "" > "$RUNNING"
    echo "Closing" >> "$LOGFILE"
else
    MEETING=$(Meetings next -j)
    echo "$MEETING" > "$LOGFILE"
    $EWW update meetingJson="${MEETING}" --config "$CONFIG" >> "$LOGFILE" 2>&1
    $EWW open meeting --config "$CONFIG" >> "$LOGFILE" 2>&1
    echo "R" > "$RUNNING"
    echo "Running" >> "$LOGFILE"
fi
