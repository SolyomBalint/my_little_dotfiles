return {
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets", { "L3MON4D3/LuaSnip", version = "v2.*" } },

        version = "*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
                ["<C-f>"] = { "select_and_accept" },
                ["<C-p>"] = { "select_prev" },
                ["<C-n>"] = { "select_next" },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            completion = {
                menu = {
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "kind" },
                            { "label",      "label_description", gap = 1 },
                            { "source_name" },
                        },
                    },
                },
                ghost_text = { enabled = true },
            },

            snippets = { preset = "luasnip" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
        },
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
}
