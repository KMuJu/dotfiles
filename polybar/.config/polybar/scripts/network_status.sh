#!/bin/bash

interface=$(iw dev | awk '$1=="Interface"{print $2}' | head -n1)
signal=$(grep "$interface" /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

# Choose signal icon
if [ "$signal" -lt 30 ]; then icon="󰤟"
elif [ "$signal" -lt 50 ]; then icon="󰤢"
elif [ "$signal" -lt 70 ]; then icon="󰤥"
else icon="󰤨"
fi

echo "$icon "
