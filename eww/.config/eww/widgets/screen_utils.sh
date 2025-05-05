#!/bin/bash

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
