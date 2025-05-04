#!/bin/bash

profile=$(powerprofilesctl get)

case "$profile" in
    "balanced") echo "󰁹 "
    ;;
    "performance") echo "󱓞 "
    ;;
    "power-saver") echo " "
    ;;
    *) echo ""
    ;;
esac

