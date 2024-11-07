
status=$(playerctl --player=spotify status 2 2> /dev/null)

if [[ "$status" = "Playing" ]]; then
    echo "󰽴"
else
    echo ""
fi
