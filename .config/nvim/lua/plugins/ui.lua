return {
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
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        config = function()
            local diags = require("tiny-inline-diagnostic")
            diags.setup({
                options = {
                    show_source = true,
                    multilines = true,
                    -- show_all_diags_on_cursorline = true,
                    -- multiple_diag_under_cursor = true,
                },
            })
            vim.api.nvim_create_user_command("ToggleTinyDiags", function()
                diags.toggle()
            end, {})
            vim.api.nvim_create_user_command("SwitchToBasicDiags", function()
                diags.disable()
                vim.diagnostic.config({ virtual_text = true })
            end, {})
            vim.api.nvim_create_user_command("SwitchToTinyDiags", function()
                diags.enable()
                vim.diagnostic.config({ virtual_text = false })
            end, {})
        end,
    },
}
