/usr/local/bin/Meetings next -j | jq -r '.start' | awk -F'[T:-]' '{ printf "%d %s %s:%s\n", $3, strftime("%b", mktime($1" "$2" "$3" 00 00 00")), $4, $5 }'

