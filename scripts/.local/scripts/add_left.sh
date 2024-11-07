
# Define your monitors
PRIMARY_MONITOR="eDP-1"
SECONDARY_MONITOR="HDMI-2"

# Check if the second monitor is currently connected and active
monitor_status=$(xrandr --query | grep "$SECONDARY_MONITOR connected" | grep -v "disconnected")

if [[ -n $monitor_status ]]; then
  # Check if the monitor is currently active
  is_active=$(xrandr --query | grep "$SECONDARY_MONITOR" | grep -o " connected ")

  if [[ $is_active == " connected " ]]; then
    # If the monitor is active, turn it off
    xrandr --output "$SECONDARY_MONITOR" --off
    echo "Second monitor turned off."
  else
    # If the monitor is not active, turn it on and set its position
    xrandr --output "$SECONDARY_MONITOR" --auto --left-of "$PRIMARY_MONITOR"
    echo "Second monitor turned on."

    source ~/.config/polybar/launch.sh
  fi
else
  echo "Second monitor ($SECONDARY_MONITOR) is not connected."
fi
