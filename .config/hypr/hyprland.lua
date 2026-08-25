-- Hyprland config, ported from hyprland.conf (hyprlang was deprecated in 0.55).
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- HDMI one monitor setup (164/66 Hz is not supported via hdmi it seems)
-- hl.monitor({ output = "desc:Samsung Electric Company LS24AG32x H9JW105851", mode = "1920x1080@144", position = "0x0",    scale = 1 })
-- hl.monitor({ output = "desc:Thermotrex Corporation TL140VDXP10",           mode = "1920x1200@144", position = "1920x0", scale = 1.5 })

-- Laptop with docker
hl.monitor({
    output = "desc:Samsung Electric Company LS24AG32x H9JW105851",
    mode = "1920x1080@164.96",
    position = "1200x0",
    scale = 1,
})
hl.monitor({
    output = "desc:Thermotrex Corporation TL140VDXP10",
    mode = "1920x1200@144",
    position = "3120x0",
    scale = 1,
})
hl.monitor({
    output = "desc:Hewlett Packard HP E241i CN44171KK9",
    mode = "1920x1200@59.95",
    position = "0x0",
    scale = 1,
    transform = 3, -- rotate by 270 degrees
})

-- Roza monitor
-- hl.monitor({ output = "desc:Thermotrex Corporation TL140VDXP10",  mode = "1920x1200@144",   position = "0x0",    scale = 1 })
-- hl.monitor({ output = "desc:Shenzhen KTC Technology Group H27D9", mode = "2560x1440@99.97", position = "1920x0", scale = 1 })

-- Only laptop
-- hl.monitor({ output = "desc:Thermotrex Corporation TL140VDXP10", mode = "1920x1200@144",  position = "0x0", scale = 1 })
-- hl.monitor({ output = "desc:Thermotrex Corporation TL140VDXP10", mode = "1920x1200@60.0", position = "0x0", scale = 1 })
-- hl.monitor({ output = "desc:Thermotrex Corporation TL140VDXP10", mode = "1920x1200@144",  position = "0x0", scale = 1.2 })
-- hl.monitor({ output = "desc:Thermotrex Corporation TL140VDXP10", mode = "1920x1200@60.0", position = "0x0", scale = 1.2 })

-- Old Home setup
-- hl.monitor({ output = "desc:Thermotrex Corporation TL140VDXP10",                        mode = "1920x1200@144",   position = "0x0",    scale = 1 })
-- hl.monitor({ output = "desc:Philips Consumer Electronics Company PHL 243V7 0x000009EE", mode = "1920x1080@74.97", position = "1920x0", scale = 1 })

-- Disable monitors (must be after the others)
-- hl.monitor({ output = "desc:Hewlett Packard HP E241i CN44171KK9",           disabled = true })
-- hl.monitor({ output = "desc:Samsung Electric Company LS24AG32x H9JW105851", disabled = true })
-- hl.monitor({ output = "desc:Thermotrex Corporation TL140VDXP10",            disabled = true })

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "wofi --show drun"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- hl.exec_cmd() spawns asynchronously through `sh -c`, so no `&`/`disown` needed.

hl.on("hyprland.start", function()
    -- hl.exec_cmd(terminal)
    -- hl.exec_cmd("nm-applet")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd(
        'tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE "$HYPRLAND_INSTANCE_SIGNATURE"'
    )
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    -- For dank linux desktop
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("dms run")

    -- hl.exec_cmd('mpvpaper --auto-pause -o "no-audio loop panscan=1.0" DP-11 ~/Pictures/backgrounds/vertical/quiet_neon_night.mp4')
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/amd-igpu")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_out = 10, -- default is 20

        border_size = 2, -- default is 1

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#variable-types for info about colors
        col = {
            active_border = "rgb(E6C384)",
            inactive_border = "rgb(727169)",
        },
    },

    decoration = {
        rounding = 10,

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
        blur = {
            size = 3, -- default is 8
        },
    },

    animations = {
        enabled = true,
    },
})

-- Animations use Hyprland's built-in defaults (global: speed 8, curve "default";
-- every other leaf inherits from it). See
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[t1]",  gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "w[tg1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ match = { float = false, workspace = "w[t1]" },  border_size = 0, rounding = 0 })
-- hl.window_rule({ match = { float = false, workspace = "w[tg1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ match = { float = false, workspace = "f[1]" },   border_size = 0, rounding = 0 })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
hl.config({
    misc = {
        allow_session_lock_restore = true,
    },
})

---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout = "us,hu",
        kb_variant = ",qwerty",
        kb_options = "grp:alt_shift_toggle",
    },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- NOTE: `gestures.workspace_swipe` no longer exists; it was replaced by hl.gesture().
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name = "inspiroy-frego-m-509-pen",
    output = "desc:Samsung Electric Company LS24AG32x H9JW105851",
})

---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + m", hl.dsp.layout("togglesplit")) -- dwindle

-- Custom
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.exec_cmd("dms ipc call lock lock"))
hl.bind(mainMod .. " + n", hl.dsp.exec_cmd("hyprsunset -t 4000"))
hl.bind(mainMod .. " + SHIFT + n", hl.dsp.exec_cmd("hyprsunset -t 6000"))
hl.bind(mainMod .. " + q", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.exec_cmd("systemctl suspend"))
-- hl.bind("ALT + l", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))
hl.bind(
    mainMod .. " + SHIFT + b",
    hl.dsp.exec_cmd("asusctl profile set Balanced")
)
hl.bind(
    mainMod .. " + SHIFT + p",
    hl.dsp.exec_cmd("asusctl profile set Performance")
)
hl.bind(mainMod .. " + SHIFT + q", hl.dsp.exec_cmd("asusctl profile set Quiet"))

-- Screen recording bindings for multiple displays
-- The focused monitor comes from hl.get_active_monitor() rather than shelling
-- out to `hyprctl monitors -j | jq`.
hl.bind(mainMod .. " + SHIFT + r", function()
    local mon = hl.get_active_monitor()
    if mon == nil then
        return
    end
    hl.dispatch(
        hl.dsp.exec_cmd(
            "wl-screenrec -o "
                .. mon.name
                .. [[ -f ~/Videos/screen-$(date +%Y%m%d_%H%M%S).mp4]]
        )
    )
end)
hl.bind(
    mainMod .. " + SHIFT + x",
    hl.dsp.exec_cmd("pkill -SIGINT wl-screenrec || pkill -SIGKILL wl-screenrec")
)
hl.bind(
    mainMod .. " + SHIFT + a",
    hl.dsp.exec_cmd(
        [[wl-screenrec -g "$(slurp)" -f ~/Videos/screen-$(date +%Y%m%d_%H%M%S).mp4]]
    )
)

-- Hyprtasking
-- hl.on("hyprland.start", function()
--     hl.exec_cmd("hyprctl plugin load /home/balintsolyom/installed_from_source/hyprland/hyprtasking/build/libhyprtasking.so")
-- end)
-- hl.bind(mainMod .. " + tab",           hl.dsp.layout("hyprtasking:toggle all"))
-- hl.bind(mainMod .. " + SHIFT + space", hl.dsp.layout("hyprtasking:toggle cursor"))
--
-- hl.bind(mainMod .. " + X", hl.dsp.layout("hyprtasking:killhovered"))
--
-- hl.bind(mainMod .. " + H", hl.dsp.layout("hyprtasking:move left"))
-- hl.bind(mainMod .. " + J", hl.dsp.layout("hyprtasking:move down"))
-- hl.bind(mainMod .. " + K", hl.dsp.layout("hyprtasking:move up"))
-- hl.bind(mainMod .. " + L", hl.dsp.layout("hyprtasking:move right"))

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl s 10%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl s 10%-"),
    { locked = true, repeating = true }
)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true }
)
hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true }
)
hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    { locked = true }
)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules
-- NOTE: the windowrule/windowrulev2 split is gone; there is only hl.window_rule() now.

-- Example window rule
-- hl.window_rule({ match = { class = "^(kitty)$" }, float = true })
-- hl.window_rule({ match = { class = "^(kitty)$", title = "^(kitty)$" }, float = true })

-- Ignore maximize requests from apps.
-- Named rules return a handle, so this can be toggled at runtime without a reload:
--   suppressMaximizeRule:set_enabled(false) / :is_enabled()
suppressMaximizeRule = hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
