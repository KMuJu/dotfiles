#!/bin/bash

# Get active workspace and monitors
active_ws=$(hyprctl activeworkspace -j | jq -r '.id')
current_monitor=$(hyprctl activeworkspace -j | jq -r '.monitor')

# Get list of monitors
monitors=($(hyprctl monitors -j | jq -r '.[].name'))

# Determine the other monitor
for mon in "${monitors[@]}"; do
  if [[ "$mon" != "$current_monitor" ]]; then
    other_monitor="$mon"
    break
  fi
done

# Move current workspace to the other monitor
hyprctl dispatch moveworkspacetomonitor "$active_ws" "$other_monitor"
