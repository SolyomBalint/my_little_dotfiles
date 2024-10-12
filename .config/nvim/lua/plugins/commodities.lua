return {
    { "cohama/lexima.vim" },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        config = function()
            require("Comment").setup({})
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            -- This module contains a number of default definitions
            local rainbow_delimiters = require("rainbow-delimiters")
            local setColours = function(group, opts)
                vim.api.nvim_set_hl(0, group, opts)
            end
            setColours("KanagawaDelimiterLightGrey", { default = true, fg = "#9CABCA", ctermfg = "LightGrey" }) -- Light Grey
            setColours("KanagawaDelimiterDeepPurple", { default = true, fg = "#957FB8", ctermfg = "Magenta" })  -- Spring Violet
            setColours("KanagawaDelimiterBrightCyan", { default = true, fg = "#6A9589", ctermfg = "Cyan" })     -- Light Blue
            setColours("KanagawaDelimiterTeal", { default = true, fg = "#7AA89F", ctermfg = "Cyan" })           -- Teal
            setColours("KanagawaDelimiterYellow", { default = true, fg = "#DCD7BA", ctermfg = "Yellow" })       -- Yellow
            setColours("KanagawaDelimiterRed", { default = true, fg = "#E46876", ctermfg = "Red" })             -- Red
            setColours("KanagawaDelimiterOrange", { default = true, fg = "#FF9E3B", ctermfg = "Yellow" })       -- Yellow

            ---@type rainbow_delimiters.config
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = function(bufnr)
                        -- Disabled for very large files, global strategy for large files,
                        -- local strategy otherwise
                        local line_count = vim.api.nvim_buf_line_count(bufnr)
                        if line_count > 5000 then
                            return nil
                        end
                        return rainbow_delimiters.strategy["global"]
                    end,
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                priority = {
                    [""] = 110,
                    lua = 210,
                },
                highlight = {
                    "KanagawaDelimiterLightGrey", -- Outermost delimiter
                    "KanagawaDelimiterDeepPurple",
                    "KanagawaDelimiterBrightCyan",
                    "KanagawaDelimiterYellow",
                    "KanagawaDelimiterTeal",
                    "KanagawaDelimiterRed",
                    "KanagawaDelimiterOrange", -- Innermost delimiter
                },
            }

            vim.api.nvim_create_user_command("ToggleBracketHighlight", function()
                rainbow_delimiters.toggle(0)
            end, {})
        end,
    },
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("dashboard").setup({
                theme = "hyper",
                config = {
                    project = {
                        action = "FzfLua files cwd=",
                    },
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
                        {
                            desc = " config",
                            group = "@property",
                            action = function()
                                require("fzf-lua").files({ cwd = vim.fn.expand("~/my_little_dotfiles/") })
                            end,
                            key = "c",
                        },
                        {
                            desc = " NeoGit",
                            group = "@property",
                            action = function()
                                require("neogit").open()
                            end,
                            key = "g",
                        },
                        {
                            desc = " Browse cwd",
                            group = "@property",
                            action = function()
                                require("fzf-lua").files()
                            end,
                            key = "s",
                        },
                    },
                },
            })
        end,
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },
    {
        "folke/drop.nvim",
        event = "VimEnter",
        enabled = false,
        config = function()
            require("drop").setup({

                ---@type DropTheme|string
                theme = "xmas",
                -- theme = "auto", -- when auto, it will choose a theme based on the date
                ---@type ({theme: string}|DropDate|{from:DropDate, to:DropDate}|{holiday:"us_thanksgiving"|"easter"})[]
                themes = {
                    { theme = "new_year",            month = 1,                       day = 1 },
                    { theme = "valentines_day",      month = 2,                       day = 14 },
                    { theme = "st_patricks_day",     month = 3,                       day = 17 },
                    { theme = "easter",              holiday = "easter" },
                    { theme = "april_fools",         month = 4,                       day = 1 },
                    { theme = "us_independence_day", month = 7,                       day = 4 },
                    { theme = "halloween",           month = 10,                      day = 31 },
                    { theme = "us_thanksgiving",     holiday = "us_thanksgiving" },
                    { theme = "xmas",                from = { month = 12, day = 24 }, to = { month = 12, day = 25 } },
                    { theme = "leaves",              from = { month = 9, day = 22 },  to = { month = 12, day = 20 } },
                    { theme = "snow",                from = { month = 12, day = 21 }, to = { month = 3, day = 19 } },
                    { theme = "spring",              from = { month = 3, day = 20 },  to = { month = 6, day = 20 } },
                    { theme = "summer",              from = { month = 6, day = 21 },  to = { month = 9, day = 21 } },
                },
                max = 75,                                            -- maximum number of drops on the screen
                interval = 100,                                      -- every 150ms we update the drops
                screensaver = 1000 * 60 * 5,                         -- show after 5 minutes. Set to false, to disable
                filetypes = { "dashboard", "alpha", "ministarter" }, -- will enable/disable automatically for the following filetypes
                winblend = 100,                                      -- winblend for the drop window
            })
        end,
    },
}
