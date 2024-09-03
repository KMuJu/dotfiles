BG=$(cat ~/background)

if [[ -f "$BG" ]]; then
    # Use feh to set the background
    feh --bg-fill "$BG"
    convert "$BG" -resize 1366x768! -blur 0x8 /tmp/bgblur.png
else
    echo "Image file not found: $BG"
fi
