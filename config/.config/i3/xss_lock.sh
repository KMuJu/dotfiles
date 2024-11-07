#!/bin/bash
xset s 300 240
xss-lock -n ~/.local/scripts/dim-screen2.sh -- (i3lock -n --image ~/Bilder/bgblur.png > $HOME/locklog)
