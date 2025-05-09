CURRENT_SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)

nmcli -t -f SSID,SIGNAL device wifi list | head -n 10 |
awk -F: -v current="$CURRENT_SSID" '
  BEGIN { print "[" }
  {
    connected = ($1 == current) ? "true" : "false"
    printf "%s{\"ssid\":\"%s\",\"signal\":\"%s\",\"connected\":%s}",
           (NR==1 ? "" : ","), $1, $2, connected
  }
  END { print "]" }
'
