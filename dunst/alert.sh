#!/usr/bin/env bash

# Play different sounds based on the body or urgency of the notification
if [[ "$DUNST_APP_NAME" =~ "Volume" || "$DUNST_APP_NAME" =~ "Brightness" ]]; then
	# Do nothing for Volume or Brightness notifications
	exit 0
else
	paplay /usr/share/sounds/freedesktop/stereo/message.oga
fi
