#!/usr/bin/env bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"
export CURRENT_BRIGHTNESS=$(brightnessctl get)

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 60 seconds, undim if user becomes active` \
  --timer 180  \
    'export CURRENT_BRIGHTNESS=$(brightnessctl get) '\
    '~/.local/scripts/dim-screen2.sh' \
    "brightnessctl set $CURRENT_BRIGHTNESS" \
  `# Undim & lock after 10 more seconds` \
  --timer 10 \
    "i3lock -c 1f1f1f; brightnessctl set $CURRENT_BRIGHTNESS" \
    '' \
  `# Finally, suspend an hour after it locks` \
  --timer 3600 \
    'systemctl suspend' \
    ''
