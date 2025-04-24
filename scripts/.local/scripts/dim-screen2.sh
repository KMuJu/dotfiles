#!/bin/bash

# Fade the screen and wait. Needs xbacklight.
# When receiving SIGHUP, stop fading and set backlight to original brightness.
# When receiving SIGTERM, wait a bit, and set backlight to original brightness
# (this prevents the screen from flashing before it is turned completely off
# by DPMS in the locker command).

min_brightness=0
fade_time=5000
fade_steps=200

current_brightness=$(brightnessctl g)
max_brightness=$(brightnessctl m)
# echo $current_brightness
# trap "brightnessctl -set $current_brightness" EXIT
# trap 'kill %%; exit 0' HUP
# trap 'sleep 1s; kill %%; exit 0' TERM


current_percent=$(( current_brightness * 100 / max_brightness ))
step_size=$(( (current_percent - min_brightness) / fade_steps ))
step_delay=$(( fade_time / fade_steps ))  # Milliseconds per step

# Ensure step size is at least 1
if [ "$step_size" -lt 1 ]; then
    step_size=1
fi

# Fade brightness down
for ((i = current_percent; i > min_brightness; i -= step_size)); do
    brightnessctl set "${i}%"
    sleep $(echo "$step_delay / 1000" | bc -l)  # Convert ms to seconds
done

# Set final brightness
brightnessctl set "${min_brightness}"
