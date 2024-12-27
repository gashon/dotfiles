#!/bin/bash

# Battery thresholds
THRESHOLDS=(20 10 5)

# Directory to track notification states
STATE_DIR="/tmp/battery_notify_states"

# Get the current battery percentage and status
BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)

# Create state directory if it doesn't exist
mkdir -p "$STATE_DIR"

# Check each threshold
for THRESHOLD in "${THRESHOLDS[@]}"; do
	STATE_FILE="$STATE_DIR/notify_${THRESHOLD}"

	if [[ "$BATTERY_LEVEL" -le "$THRESHOLD" && "$BATTERY_STATUS" == "Discharging" ]]; then
		if [[ ! -f "$STATE_FILE" ]]; then
			# Send notification if not already sent for this threshold
			notify-send -u critical "Low Battery" "Battery level is at $BATTERY_LEVEL%. Please plug in your charger."
			touch "$STATE_FILE"
		fi
	else
		# Remove state file if battery is above threshold or charging
		rm -f "$STATE_FILE"
	fi
done
