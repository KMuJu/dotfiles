echo "$(date): HDMI event triggered" >> /tmp/hdmi_log.txt
betterlockscreen -u $(cat ~/background) &
/usr/bin/xrandr --output HDMI-A-0 --auto --left-of eDP
sleep 0.2
/usr/bin/i3-msg restart
/usr/bin/i3-msg 'move workspace to output left'
