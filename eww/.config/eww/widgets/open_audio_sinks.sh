#!/bin/bash

# EWW="$HOME/apps/eww/target/release/eww"
WIDGET="audio_sinks"
CONFIG="$HOME/.config/eww/widgets"
LOGFILE="$HOME/.cache/eww/${WIDGET}_audio_control.log"

function log {
    echo "$(date): $1" >> "$LOGFILE"
    echo "$(date): $1"
}

log "Running script at $(date)"
log "CONFIG: $CONFIG"

eww daemon --config "$CONFIG" >> "$LOGFILE" 2>&1
    
sinks=$($CONFIG/scripts/wpctl.py) 
echo $sinks

# https://gitlab.com/Kamcuk/kamilscripts/-/blob/master/bin/,x
# x-server functions functions

# @return name width height xoff yoff
x_get_monitors() {
	xrandr |
	sed -E '
		/^([^ ]*) connected /!d
		s/^([^ ]*).*[^-0-9]([-0-9]+)x([-0-9]+)\+([-0-9]+)\+([-0-9]+)[^-0-9].*$/\1 \2 \3 \4 \5/
	'
}

x_get_monitor_from_mouse() {
	# Get the window position
	eval "$(xdotool getmouselocation --shell)"

	# Loop through each screen and compare the offset with the window
	# coordinates.
	x_get_monitors |
	{
		while read -r name width height xoff yoff; do
		    if ((
					$X >= xoff &&
					$Y >= yoff &&
					$X < xoff + width &&
					$Y < yoff + width
					)); then
		        # printf "%s\n" "$name" "$width" "$height" "$xoff" "$yoff" "$X" "$Y" | paste -sd' '
                echo $name
                break
		    fi
		done
		echo "Could not find any monitor for the current mouse position." >&2
	}
}


screen=$(x_get_monitor_from_mouse)

eww update sinks_json="${sinks}" --config "$CONFIG" >> "$LOGFILE" 2>&1
eww open audio_control --toggle --screen $screen --duration "30s" --config "$CONFIG" >> "$LOGFILE" 2>&1

if [[ "$1" == "inspect" ]]; then
    eww inspector --config "$CONFIG" >> "$LOGFILE"
fi
