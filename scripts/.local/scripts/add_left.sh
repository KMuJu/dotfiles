# Define your monitors
PRIMARY_MONITOR="eDP-1"
SECONDARY_MONITOR="HDMI-2"

# Check if the secondary monitor is connected
if xrandr --query | grep -q "^$SECONDARY_MONITOR connected"; then
  # Check if the monitor is currently active (not "disconnected" but actually displaying something)
  is_active=$(xrandr --query | grep "^$SECONDARY_MONITOR" | grep -o "[0-9]\+x[0-9]\+")

  if [[ -n $is_active ]]; then
    # If the monitor is active, turn it off
    xrandr --output "$SECONDARY_MONITOR" --off
    echo "Second monitor turned off."
  else
    # If the monitor is connected but not active, turn it on and set its position
    xrandr --output "$SECONDARY_MONITOR" --auto --left-of "$PRIMARY_MONITOR"
    echo "Second monitor turned on."

    sleep 1
    # Relaunch polybar
    source ~/.config/polybar/launch.sh
  fi
else
  echo "Second monitor ($SECONDARY_MONITOR) is not connected."
fi
