#!/bin/bash

case "$1" in
    performance|balanced|power-saver) 
    ;;
    *) 
    ;;
esac

if [[ "$1" == "performance" || "$1" == "balanced" || "$1" == "power-saver" ]]; then
    echo "$1 ble trykket"
    powerprofilesctl set $1
    polybar-msg action power hook 0
    ~/.config/eww/widgets/open_power_profiles.sh
fi
