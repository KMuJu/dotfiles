#!/bin/bash

status=$(playerctl --player=spotify status 2 2> /dev/null)
if [[ "$status" != "Playing" ]]; then
    echo "Not playing"
    exit 0
fi

playingPath="/tmp/dunstPlaying"
idPath="/tmp/dunstID"
songPath="/tmp/song"
prevUrlPath="/tmp/songUrl"
prevURL=$(cat "$prevUrlPath")
id=$(cat $idPath)
playing=$(cat $playingPath)

echo $id
if [[ $playing == 1 ]]; then
    dunstify --close=$id
    echo -1 > $idPath
    echo 0 > $playingPath
    echo "Closed"
    exit
fi
echo 1 > $playingPath

name=$(playerctl --player=spotify metadata -f "{{playerName}}")
title=$(playerctl --player=spotify metadata -f "{{title}}")
artist=$(playerctl --player=spotify metadata -f "{{artist}}")
artUrl=$(playerctl --player=spotify metadata -f "{{mpris:artUrl}}")

position=$(playerctl --player=spotify metadata -f '{{position}}')
length=$(playerctl --player=spotify metadata -f "{{mpris:length}}")
if [ -n "$position" ] && [ -n "$length" ]; then
    # Perform the calculation to get the percentage
    percent=$(echo "scale=4; $position / $length * 100" | bc)
fi


if [[ $prevURL != $artUrl ]]; then
    wget -O $songPath $artUrl
    echo $artUrl > $prevUrlPath
fi

p=$percent

while [ $(cat $playingPath) == 1 ]; do
    position=$(playerctl --player=spotify metadata -f '{{position}}')
    if [ -n "$position" ] && [ -n "$length" ]; then
        # Perform the calculation to get the percentage
        percent=$(echo "scale=4; $position / $length * 100" | bc)
    fi
    if [[ $p != $percent ]]; then
        id=$(dunstify -p -i "$songPath" \
            "$title" "$artist" \
            -u low \
            -h int:value:$percent\
            -t 0 \
        )

        echo $id > $idPath
        p=$percent
    fi
    sleep 1
done
