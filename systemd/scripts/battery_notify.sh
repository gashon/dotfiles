#!/bin/bash

# Battery threshold
THRESHOLD=20

# State file to track notification status
STATE_FILE="/tmp/battery_notify_sent"

# Get the current battery percentage
BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)

# Check if battery is below threshold and discharging
if [[ "$BATTERY_LEVEL" -le "$THRESHOLD" && "$BATTERY_STATUS" == "Discharging" ]]; then
	if [[ ! -f "$STATE_FILE" ]]; then
		# Send notification if not already sent
		notify-send -u critical "Low Battery" "Battery level is at $BATTERY_LEVEL%."
		touch "$STATE_FILE"
	fi
else
	# Remove state file if battery is above threshold or charging
	rm -f "$STATE_FILE"
fi
