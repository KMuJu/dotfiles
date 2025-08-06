#!/bin/bash

if [[ $1 == "audio_sinks" ]]; then
    ~/.config/eww/widgets/open_audio_sinks.sh
elif [[ $1 == "power_profiles" ]]; then
    ~/.config/eww/widgets/open_power_profiles.sh
elif [[ $1 == "wifi" ]]; then
    ~/.config/eww/widgets/wifi/open_wifi.sh
fi

