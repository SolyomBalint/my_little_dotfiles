#!/bin/bash
# `hyprctl keyword` doesn't work with the Lua config parser, so use `hyprctl eval`.

HP="desc:Hewlett Packard HP E241i CN44171KK9"
SAMSUNG="desc:Samsung Electric Company LS24AG32x H9JW105851"

set_layout() {
    local samsung_pos="$1"
    hyprctl eval "hl.monitor({ output = \"$HP\", mode = \"1920x1200@59.95\", position = \"0x0\", scale = 1, transform = 3 })"
    hyprctl eval "hl.monitor({ output = \"$SAMSUNG\", mode = \"1920x1080@164.96\", position = \"$samsung_pos\", scale = 1 })"
}

# Derive the current mode from the real layout (Samsung at y=2000 means gaming mode),
# so the state can't go stale after a config reload.
samsung_y=$(hyprctl monitors -j | jq -r --arg d "${SAMSUNG#desc:}" '.[] | select(.description == $d) | .y')

if [ "$samsung_y" != "2000" ]; then
    # Samsung sits far below/right of HP so the cursor can't leave it
    set_layout "1200x2000"
    notify-send "Gaming Mode" "Cursor confined to Samsung"
else
    set_layout "1200x0"
    notify-send "Gaming Mode" "Normal layout restored"
fi
