#!/bin/bash
# Usage: brightness_all.sh increment|decrement [STEP]
# Keeps every screen at the same brightness. The laptop panel goes through DMS
# (so its OSD shows), external monitors are set directly over DDC/CI. DDC is
# slow and the dock chokes on overlapping writes, so rapid presses only update
# a target file and a single locked worker pushes the latest value to them.
ACTION="$1"
STEP="${2:-10}"

STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/brightness_all"
TARGET_FILE="$STATE_DIR/target"
APPLIED_FILE="$STATE_DIR/applied"
BUSES_FILE="$STATE_DIR/buses"
mkdir -p "$STATE_DIR"

BACKLIGHT=$(brightnessctl -l -c backlight -m | head -1 | cut -d, -f1)

current_brightness() {
    # Trust the last target while presses are still coming in, the backlight
    # write from DMS may not have landed yet.
    if [ -f "$TARGET_FILE" ] && [ $(($(date +%s) - $(stat -c %Y "$TARGET_FILE"))) -lt 3 ]; then
        cat "$TARGET_FILE"
        return
    fi
    local raw max
    raw=$(brightnessctl -d "$BACKLIGHT" g)
    max=$(brightnessctl -d "$BACKLIGHT" m)
    echo $(((raw * 100 + max - 1) / max))
}

# Valid DDC displays, skipping the internal panel. Detection takes seconds, so
# an empty result (undocked) is cached too, but retried after a minute.
ddc_buses() {
    if [ ! -f "$BUSES_FILE" ] || { [ ! -s "$BUSES_FILE" ] && [ -n "$(find "$BUSES_FILE" -mmin +1)" ]; }; then
        timeout 20 ddcutil detect --terse 2>/dev/null | awk '
            /^Display/            { valid = 1; bus = ""; edp = 0 }
            /^Invalid display/    { valid = 0 }
            /I2C bus:/            { bus = $NF; sub(".*i2c-", "", bus) }
            /DRM.*eDP/            { edp = 1 }
            /^$/ && valid && bus != "" && !edp { print bus; valid = 0 }
            END { if (valid && bus != "" && !edp) print bus }
        ' >"$BUSES_FILE"
    fi
    cat "$BUSES_FILE"
}

sync_ddc() {
    exec 9>"$STATE_DIR/lock"
    flock -n 9 || return
    local target
    while target=$(cat "$TARGET_FILE") && [ "$target" != "$(cat "$APPLIED_FILE" 2>/dev/null)" ]; do
        for bus in $(ddc_buses); do
            # A failed write usually means the monitors were re-plugged
            timeout 5 ddcutil --bus "$bus" --noverify setvcp 10 "$target" >/dev/null 2>&1 || rm -f "$BUSES_FILE"
        done
        echo "$target" >"$APPLIED_FILE"
    done
    exec 9>&-
}

(
    flock 8
    current=$(current_brightness)
    case "$ACTION" in
    increment) target=$((current + STEP)) ;;
    decrement) target=$((current - STEP)) ;;
    *)
        echo "Usage: $0 increment|decrement [STEP]" >&2
        exit 1
        ;;
    esac
    ((target > 100)) && target=100
    ((target < 1)) && target=1
    echo "$target" >"$TARGET_FILE"
) 8>"$STATE_DIR/press_lock" || exit 1

dms ipc call brightness set "$(cat "$TARGET_FILE")" "backlight:$BACKLIGHT" >/dev/null

# Re-check after releasing the lock so a press that raced the worker's exit
# is not lost
while [ "$(cat "$TARGET_FILE")" != "$(cat "$APPLIED_FILE" 2>/dev/null)" ]; do
    sync_ddc
    flock -n "$STATE_DIR/lock" true || break
done &
disown
