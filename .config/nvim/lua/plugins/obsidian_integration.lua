local custom_functions = require("custom_functions")
local local_infos = nil
local workspaces = {
    {
        name = "slip_box",
        path = "~/obsidian/slip_box",
    },
}

if custom_functions.isModuleAvailable("local_additions") then
    local_infos = require("local_additions")
    workspaces = local_infos.workspaces
end

return {
    "epwalsh/obsidian.nvim",
    version = "*",
    enabled = false,
    lazy = true,
    event = {
        "BufReadPre *.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "ibhagwan/fzf-lua",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        workspaces = workspaces,
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        picker = {
            name = "fzf-lua",
        },
        templates = {
            folder = "6_templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },
        mappins = {},
    },
}
