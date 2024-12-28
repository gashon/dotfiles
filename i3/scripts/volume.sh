#!/usr/bin/env bash
# Show current volume level in a notification.

# 1. Adjust the volume by +5 or -5
pactl set-sink-volume @DEFAULT_SINK@ "$1"

# 2. Retrieve the current volume percentage
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ |
	grep -o '[0-9]*%' |
	head -n1 |
	tr -d '%')

# 3. Send notification with Dunstify.
#    -r 999 means replace any existing "volume" notification
#    -h int:value:$VOLUME sets the progress bar to $VOLUME
dunstify -a "Volume" \
	-r 999 \
	-h int:value:"$VOLUME" \
	"Volume: ${VOLUME}%"
