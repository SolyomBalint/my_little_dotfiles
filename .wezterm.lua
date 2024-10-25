-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Color scheme settings
config.color_scheme = "Kanagawa (Gogh)"
-- config.color_scheme = 'Kanagawa Dragon (Gogh)'
-- config.window_background_image = "/home/solyombalint/Pictures/nvimbackground.jpg"

-- Window appearance settings
config.hide_tab_bar_if_only_one_tab = true
-- config.window_background_opacity = 0.9
config.window_background_image_hsb = {
    brightness = 0.1,
}

-- This is to make using neovim easier, refer ti tge keyboard concepts docs for more information.
config.use_dead_keys = false

-- Key Settings

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    {
        key = "a",
        mods = "LEADER",
        action = wezterm.action.ToggleFullScreen,
    },
    { key = "L", mods = "CTRL|SHIFT", action = wezterm.action.ShowDebugOverlay },
    {
        key = "v",
        mods = "LEADER",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "h",
        mods = "LEADER",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "f",
        mods = "LEADER",
        action = wezterm.action.TogglePaneZoomState,
    },
}

-- Domains
config.unix_domains = {
    {
        name = "unix",
    },
}

config.default_gui_startup_args = { "connect", "unix" }

-- Performance settings
config.enable_wayland = true
for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
    if gpu.backend == "Vulkan" then
        -- TODO make sure that if there is no discrete gpu this still works
        if gpu.device_type == "DiscreteGpu" then
            config.webgpu_preferred_adapter = gpu
            break
        end
    end
end

config.front_end = "WebGpu"
return config
