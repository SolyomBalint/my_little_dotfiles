#!/bin/bash
STATE_FILE="/tmp/hypr_gaming_mode"

HP="desc:Hewlett Packard HP E241i CN44171KK9"
SAMSUNG="desc:Samsung Electric Company LS24AG32x H9JW105851"
LAPTOP="desc:Thermotrex Corporation TL140VDXP10"

if [ ! -f "$STATE_FILE" ] || [ "$(cat $STATE_FILE)" = "off" ]; then
    # HP renders as 1200x1920, spans y=0..1920
    # Place Samsung at y=1921 — 1px below HP's bottom edge, no shared boundary
    # Place Laptop at a y that doesn't overlap Samsung's y=1921..3001 range
    # Laptop is 1200px tall, place it at y=0 so it spans y=0..1200
    # Samsung spans y=1921..3001, Laptop spans y=0..1200 — zero overlap on the right edge
    hyprctl keyword monitor "$HP, 1920x1200@59.95, 0x0, 1, transform, 3"
    hyprctl keyword monitor "$SAMSUNG, 1920x1080@164.96, 1200x2000, 1"
    hyprctl keyword monitor "$LAPTOP, 1920x1200@144, 3120x0, 1"
    echo "on" >"$STATE_FILE"
    notify-send "Gaming Mode" "Cursor confined to Samsung"
else
    hyprctl keyword monitor "$SAMSUNG, 1920x1080@164.96, 1200x0, 1"
    hyprctl keyword monitor "$LAPTOP, 1920x1200@144, 3120x0, 1"
    hyprctl keyword monitor "$HP, 1920x1200@59.95, 0x0, 1, transform, 3"
    echo "off" >"$STATE_FILE"
    notify-send "Gaming Mode" "Normal layout restored"
fi
