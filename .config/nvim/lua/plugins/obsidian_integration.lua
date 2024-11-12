local local_infos = require("local_additions")

return {
    "epwalsh/obsidian.nvim",
    version = "*",
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
        workspaces = local_infos.workspaces,
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
