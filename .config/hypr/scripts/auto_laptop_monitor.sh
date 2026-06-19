#!/bin/bash
# Enable the laptop's internal panel only when the two external monitors are
# NOT both connected. When both Samsung and HP are plugged in, disable it.

LAPTOP="desc:Thermotrex Corporation TL140VDXP10"
SAMSUNG="Samsung Electric Company LS24AG32x H9JW105851"
HP="Hewlett Packard HP E241i CN44171KK9"

mons=$(hyprctl monitors all -j)

connected() {
    echo "$mons" | jq -e --arg d "$1" 'any(.[]; .description | contains($d))' >/dev/null
}

if connected "$SAMSUNG" && connected "$HP"; then
    hyprctl keyword monitor "$LAPTOP, disable"
else
    hyprctl keyword monitor "$LAPTOP, 1920x1200@144, auto, 1"
fi
