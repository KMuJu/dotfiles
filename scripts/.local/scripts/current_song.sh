#!/bin/bash

idPath="/tmp/dunstID"
songPath="/tmp/song"
prevUrlPath="/tmp/songUrl"
prevURL=$(cat "$prevUrlPath")
id=$(cat $idPath)

echo $id
count=$(dunstctl count displayed)
echo "Count $count"
if [[ $count != 0 ]]; then
    dunstify --close=$id
    echo -1 > $idPath
    echo "Closed"
    exit
fi

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

id=$(dunstify -p -i "$songPath" \
    "$title" "$artist" \
    -u low \
    -h int:value:$percent\ # show how percentage of the 
)

echo $id > $idPath
echo $id
