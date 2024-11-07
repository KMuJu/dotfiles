#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log 
# polybar bar 2>&1 | tee -a /tmp/polybar1.log & disown

# Get the names of connected monitors
monitors=($(xrandr --query | grep " connected" | cut -d" " -f1))

# Launch Polybar on each connected monitor
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

for monitor in "${monitors[@]}"; do
  MONITOR=$monitor polybar bar 2>&1 | tee -a /tmp/polybar_$monitor.log & disown
done

echo "Bars launched..."
