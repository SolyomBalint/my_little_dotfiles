#!/bin/bash
# DMS binds bars to monitors by connector name (eDP-1, DP-9, ...), which the
# kernel renumbers after updates/dock replugs. Re-match every saved
# {name, model} screen preference to the connector that currently has that
# model, and restart DMS if anything changed.

SETTINGS="$HOME/.config/DankMaterialShell/settings.json"

mons=$(hyprctl monitors all -j) || exit 1
new=$(jq --argjson mons "$mons" '
    ($mons | map({key: .model, value: .name}) | from_entries) as $byModel
    | walk(
        if type == "object" and has("name") and has("model") and $byModel[.model]
        then .name = $byModel[.model]
        else . end
    )
' "$SETTINGS") || exit 1

if [ "$new" != "$(jq . "$SETTINGS")" ]; then
    cp "$SETTINGS" "$SETTINGS.bak"
    printf '%s\n' "$new" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
    dms restart
    notify-send "DMS" "Monitor names changed, bars re-assigned"
fi
