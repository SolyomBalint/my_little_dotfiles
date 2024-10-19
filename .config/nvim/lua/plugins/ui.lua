return {
    -- lazy.nvim
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        enabled = false,
        opts = {
            -- add any options here
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                config = function()
                    require("notify").setup({
                        render = "wrapped-compact",
                        max_width = function()
                            return math.floor(vim.api.nvim_win_get_width(0) / 3)
                        end,
                    })
                end,
            },
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
                popupmenu = {
                    enabled = true, -- enables the Noice popupmenu UI
                    ---@type 'nui'|'cmp'
                    backend = "nui", -- backend to use to show regular cmdline completions
                    ---@type NoicePopupmenuItemKind|false
                    -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
                    kind_icons = {}, -- set to `false` to disable icons
                },
            })
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
