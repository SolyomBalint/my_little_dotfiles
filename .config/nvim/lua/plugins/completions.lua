return {
    {
        "saghen/blink.cmp",
        lazy = false,
        -- optional: provides snippets for the snippet source
        dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },

        -- use a release tag to download pre-built binaries
        version = "v0.*",
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
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

            list = {
                max_items = 20,
            },

            accept = {
                auto_brackets = {
                    enabled = true,
                },
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
            },
            snippets = {
                expand = function(snippet)
                    require("luasnip").lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction)
                    require("luasnip").jump(direction)
                end,
            },
            -- default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, via `opts_extend`
            sources = {
                completion = {
                    enabled_providers = { "lsp", "path", "snippets", "buffer" },
                },
            },
        },
        -- allows extending the enabled_providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.completion.enabled_providers" },
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
    -- {
    --     "iguanacucumber/magazine.nvim",
    --     name = "nvim-cmp", -- Otherwise highlighting gets messed up
    --     dependencies = {
    --         { "hrsh7th/cmp-cmdline" },
    --         {
    --             "hrsh7th/cmp-path",
    --         },
    --         { "dmitmel/cmp-cmdline-history" },
    --     },
    --     config = function()
    --         local cmp = require("cmp")
    --         local max_buffer_size = 1024 * 1024 -- 1 Megabyte max
    --
    --         local buffer_source = {
    --             name = "buffer",
    --             option = {
    --                 get_bufnrs = function()
    --                     local buf = vim.api.nvim_get_current_buf()
    --                     local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
    --                     if byte_size > max_buffer_size then
    --                         return {}
    --                     end
    --                     return { buf }
    --                 end,
    --                 indexing_interval = 1000,
    --             },
    --         }
    --
    --         cmp.setup({
    --             window = { -- how to completion window should look
    --                 completion = cmp.config.window.bordered(),
    --                 documentation = cmp.config.window.bordered(),
    --             },
    --             performance = {
    --                 max_view_entries = 10,
    --                 fetching_timeout = 5,
    --             },
    --             mapping = cmp.mapping.preset.insert({
    --                 ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    --                 ["<C-f>"] = cmp.mapping.scroll_docs(4),
    --                 ["<C-Space>"] = cmp.mapping.complete(),
    --                 ["<C-e>"] = cmp.mapping.abort(),
    --                 ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    --             }),
    --             sorting = {
    --                 priority_weight = 1,
    --                 comparators = {
    --                     cmp.config.compare.offset,
    --                     cmp.config.compare.exact,
    --                     cmp.config.compare.recently_used,
    --                     require("clangd_extensions.cmp_scores"),
    --                     cmp.config.compare.kind,
    --                     cmp.config.compare.sort_text,
    --                     cmp.config.compare.length,
    --                     cmp.config.compare.order,
    --                 },
    --             },
    --         })
    --         cmp.setup.cmdline(":", {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = cmp.config.sources({
    --                 {
    --                     name = "path",
    --                     option = {
    --                         trailing_slash = true,
    --                     },
    --                 },
    --             }, {
    --                 {
    --                     name = "cmdline",
    --                 },
    --             }, {
    --                 buffer_source,
    --             }, {
    --                 { name = "cmdline_history" },
    --             }),
    --         })
    --         cmp.setup.cmdline("/", {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = cmp.config.sources({
    --                 {
    --                     name = "path",
    --                     option = {
    --                         trailing_slash = true,
    --                     },
    --                 },
    --             }, {
    --                 { name = "cmdline_history" },
    --             }),
    --         })
    --         cmp.setup.cmdline("?", {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = cmp.config.sources({
    --                 buffer_source,
    --             }, {
    --                 { name = "cmdline_history" },
    --             }),
    --         })
    --         cmp.setup.cmdline("@", {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = cmp.config.sources({
    --                 {
    --                     name = "path",
    --                     option = {
    --                         trailing_slash = true,
    --                     },
    --                 },
    --             }, {
    --                 {
    --                     name = "cmdline",
    --                 },
    --             }),
    --         })
    --     end,
    -- },
}
