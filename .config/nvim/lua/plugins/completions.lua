return {
    -- TODO check avante source
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "xzbdmw/colorful-menu.nvim",
            "mikavilpas/blink-ripgrep.nvim",
            { "L3MON4D3/LuaSnip", version = "v2.*" },
        },

        version = "1.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
                ["<C-f>"] = { "select_and_accept" },
                ["<C-p>"] = { "select_prev" },
                ["<C-n>"] = { "select_next" },
            },
            cmdline = {
                enabled = true,
                completion = { menu = { auto_show = true } },
                keymap = {
                    preset = "default",
                    ["<C-p>"] = { "select_prev" },
                    ["<C-n>"] = { "select_next" },
                    ["<C-f>"] = { "select_and_accept" },
                },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            completion = {
                menu = {
                    auto_show = true,
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "kind" },
                            { "label", gap = 1 },
                            { "source_name" },
                        },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
                ghost_text = { -- this is bugged atm check it later
                    enabled = false,
                    show_with_menu = false,
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 1000,
                },
            },
            signature = {
                enabled = true,
                trigger = {
                    enabled = true,
                    show_on_insert = true,
                },
                window = {
                    show_documentation = false,
                },
            },
            snippets = { preset = "luasnip" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
                providers = {
                    ripgrep = {
                        module = "blink-ripgrep",
                        name = "Ripgrep",
                        opts = {
                            prefix_min_len = 5,
                            fallback_to_regex_highlighting = true,
                            backend = {
                                ripgrep = {
                                    max_filesize = "1M",
                                    search_casing = "--ignore-case",
                                },
                            },
                        },
                    },
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        opts_extend = { "sources.default" },
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip").config.setup({
                enable_autosnippets = true,
                store_selection_key = "<Tab>",
            })
            require("luasnip.loaders.from_vscode").lazy_load()
            -- require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/LuaSnip/" })
        end,
    },
    {
        "xzbdmw/colorful-menu.nvim",
        config = function()
            require("colorful-menu").setup({
                ls = {
                    lua_ls = {
                        arguments_hl = "@comment",
                    },
                    clangd = {
                        extra_info_hl = "@comment",
                        align_type_to_right = true,
                        import_dot_hl = "@comment",
                        preserve_type_when_truncate = true,
                    },
                    basedpyright = {
                        extra_info_hl = "@comment",
                    },
                    fallback = true,
                    fallback_extra_info_hl = "@comment",
                },
                fallback_highlight = "@variable",
                max_width = 60,
            })
        end,
    },
}
