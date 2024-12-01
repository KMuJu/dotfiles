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

if [[ $prevURL != $artUrl ]]; then
    wget -O $songPath $artUrl
    echo $artUrl > $prevUrlPath
fi

id=$(dunstify -p -i "$songPath" "$title" "$artist")
echo $id > $idPath
echo $id
