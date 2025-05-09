#!/bin/bash

inKnown=$(nmcli connection show | grep "$1")
echo $inKnown
echo $2
if [ -n "$inKnown" ]; then
    echo "known connection"
    ~/.config/eww/widgets/wifi/open_wifi.sh
    if [ $2 == "*" ]; then
        dunstify "Wifi" "Already connected"
    else
        echo "'$1'"
        nmcli connection up "$1"
        dunstify "Wifi" "Connected to $1"
    fi
    exit
fi

password=$(rofi -dmenu -password -p "${1} password: " -theme ~/.config/rofi.Kasper/config.rasi)
~/.config/eww/widgets/wifi/open_wifi.sh

if [ -z "$password" ]; then
    echo "Password not provided. Exiting."
    dunstify "Wifi" "Not implemented for open networks"
    exit 1
fi

nmcli dev wifi connect "$1" password "$password"
success=$?


if [ $success == 0 ]; then
    dunstify "Wifi" "Connected to $1 for the first time"
else
    dunstify "Wifi" "Wrong password"
fi

