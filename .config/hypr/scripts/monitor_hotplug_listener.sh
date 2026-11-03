#!/bin/bash
# Listens to Hyprland's event socket and runs SCRIPT (first argument, default:
# re-evaluate the laptop panel state) whenever a monitor is connected or
# disconnected.

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
SCRIPT="${1:-$HOME/.config/hypr/scripts/auto_laptop_monitor.sh}"

# Apply once on startup.
"$SCRIPT"

socat -U - "UNIX-CONNECT:$SOCKET" | while read -r line; do
    case "$line" in
        monitoraddedv2\>\>*|monitorremovedv2\>\>*|monitoradded\>\>*|monitorremoved\>\>*)
            "$SCRIPT"
            ;;
    esac
done
