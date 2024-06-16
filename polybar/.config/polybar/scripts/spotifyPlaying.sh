
status=$(playerctl --player=spotify status 2)

if [[ "$status" = "Playing" ]]; then
    echo "󰽴"
else
    echo ""
fi
