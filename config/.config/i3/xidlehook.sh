#!/usr/bin/env bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"
brightnessctl get > /tmp/brightness
# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --socket /tmp/xidlehook.sock \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 60 seconds, undim if user becomes active` \
  --timer 180  \
    'brightnessctl get > /tmp/brightness; ~/.local/scripts/dim-screen2.sh' \
    '~/.config/i3/xidlehook_control.sh reset_brightness' \
  `# Undim & lock after 10 more seconds` \
  --timer 10 \
    "~/.config/i3/lock_fullscreen.sh" \
    '' \
  `# Finally, suspend an hour after it locks` \
  # --timer 3600 \
  --timer 3600 \
    'systemctl suspend' \
    '' > /tmp/xidlehook.log 2>&1
