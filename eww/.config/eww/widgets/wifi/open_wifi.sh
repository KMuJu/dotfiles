#!/bin/bash


nmcli device wifi rescan
# EWW="$HOME/apps/eww/target/release/eww"
WIDGET="wifi"
CONFIG="$HOME/.config/eww/widgets"
LOGFILE="$HOME/.cache/eww/${WIDGET}.log"
source "$CONFIG/screen_utils.sh"
source "$CONFIG/utils.sh"

log "Running $WIDGET script"

# eww daemon --config "$CONFIG" >> "$LOGFILE" 2>&1
    
screen=$(x_get_monitor_from_mouse)
wifi=$(python $CONFIG/wifi/scripts/get_wifi.py)

function rescan() {
    nmcli device wifi list > /dev/null
    wifi=$(python $CONFIG/wifi/scripts/get_wifi.py)
    eww update wifi_json="${wifi}" --config "$CONFIG" >> "$LOGFILE" 2>&1
}

# echo $wifi

rescan &

eww update wifi_json="${wifi}" --config "$CONFIG" >> "$LOGFILE" 2>&1
eww open $WIDGET --toggle --screen $screen --duration "30s" --config "$CONFIG" >> "$LOGFILE" 2>&1

if [[ "$1" == "inspect" ]]; then
    eww inspector --config "$CONFIG" >> "$LOGFILE"
fi
