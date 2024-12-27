#!/bin/bash

MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
LED_PATH="/sys/class/leds/platform::mute/brightness"

TOGGLE=$(cat "$LED_PATH")

if [ "$TOGGLE" == "0" ]; then
	echo 1 | sudo tee $LED_PATH # Turn ON the mute LED
else
	echo 0 | sudo tee $LED_PATH # Turn OFF the mute LED
fi
