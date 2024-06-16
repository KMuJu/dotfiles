#!/bin/bash

EWW=$HOME/apps/eww/target/release/eww
CONFIG=$HOME/.config/eww/music

function show {
    $EWW daemon --config $CONFIG
    $EWW open volume --config $CONFIG
    sleep 2
    $EWW close volume --config $CONFIG
}

if [ "$1" == "up" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ +10%
    VOLUME=$(pactl list sinks | grep 'Volume:' | head -n 1 | awk -F / '{print $2}' | tr -d '% ')
    $EWW update volume=$VOLUME --config $CONFIG
    show
elif [ "$1" == "down" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ -10%
    VOLUME=$(pactl list sinks | grep 'Volume:' | head -n 1 | awk -F / '{print $2}' | tr -d '% ')
    $EWW update volume=$VOLUME --config $CONFIG
    show
fi

