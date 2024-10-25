return {
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "onsails/lspkind.nvim",
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
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
        "iguanacucumber/magazine.nvim",
        name = "nvim-cmp", -- Otherwise highlighting gets messed up
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
            { "hrsh7th/cmp-buffer" },
            -- {
            --     "uga-rosa/cmp-dictionary",
            --     lazy = true,
            --     config = function()
            --         require("cmp_dictionary").setup({
            --             paths = { "/usr/share/dict/words" },
            --             exact_length = 2,
            --         })
            --     end,
            -- },
            -- { "f3fora/cmp-spell" },
            { "hrsh7th/cmp-nvim-lsp-document-symbol" },
            { "FelipeLema/cmp-async-path" },
            {
                "lukas-reineke/cmp-rg",
                enabled = function()
                    return vim.fn.executable("rg") == 1
                end,
            },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-calc" },
            {
                "hrsh7th/cmp-path",
            },
            { "dmitmel/cmp-cmdline-history" },
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            require("luasnip.loaders.from_vscode").lazy_load()
            local max_buffer_size = 1024 * 1024 -- 1 Megabyte max

            local buffer_source = {
                name = "buffer",
                option = {
                    get_bufnrs = function()
                        local buf = vim.api.nvim_get_current_buf()
                        local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                        if byte_size > max_buffer_size then
                            return {}
                        end
                        return { buf }
                    end,
                    indexing_interval = 1000,
                },
            }

            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        -- maxwidth = 50,
                        maxwidth = function()
                            return math.floor(0.45 * vim.o.columns)
                        end,
                        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                        menu = vim.tbl_extend(
                            "keep",
                            {
                                nvim_lsp = "[LSP]",
                                path = "[Path]",
                                nvim_lua = "[Lua]",
                                buffer = "[Buffer]",
                            },
                            { luasnip = "[LuaSnip]" },
                            -- { dictionary = "[Dictionary]" },
                            -- { spell = "[Spell]" },
                            { async_path = "{AsyncPath}" },
                            { rg = "[RG]" },
                            { cmdline = "[CmdLine]" },
                            { cmdline_history = "{CmdLineHistory}" },
                            { calc = "[Calc]" }
                        ),

                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        before = function(entry, vim_item)
                            return vim_item
                        end,
                    }),
                },
                snippet = {
                    expand = function(args) -- which snippet engine should be used
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = { -- how to completion window should look
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                performance = {
                    max_view_entries = 10,
                    fetching_timeout = 2,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority_weight = 150, group_index = 1 },
                    { name = "luasnip", priority_weight = 150, group_index = 1 }, -- For luasnip users.
                    {
                        name = "nvim_lua",
                        entry_filter = function()
                            if vim.bo.filetype ~= "lua" then
                                return false
                            end
                            return true
                        end,
                        priority_weight = 150,
                        group_index = 1,
                    },
                    { name = "cmp-nvim-lsp-document-symbol", priority_weight = 100, group_index = 2 },
                    {
                        name = "rg",
                        keyword_length = 5,
                        max_item_count = 5,
                        option = {
                            additional_arguments = "--max-depth 6 --one-file-system --ignore-file ~/.config/nvim/ignore.rg --smart-case --hidden --no-ignore-vcs",
                        },
                        priority_weight = 80,
                        group_index = 3,
                    },
                    -- {
                    --     name = "dictionary",
                    --     keyword_length = 2,
                    --     priority_weight = 50,
                    --     entry_filter = function()
                    --         local filetype = vim.bo.filetype
                    --         if filetype == "markdown" or filetype == "txt" or filetype == "tex" then
                    --             return true
                    --         end
                    --         return false
                    --     end,
                    --     group_index = 4,
                    -- },
                    -- {
                    --     name = "spell",
                    --     priority_weight = 50,
                    --     group_index = 4,
                    --     entry_filter = function()
                    --         local filetype = vim.bo.filetype
                    --         if filetype == "markdown" or filetype == "txt" or filetype == "tex" then
                    --             return true
                    --         end
                    --         return false
                    --     end,
                    --     option = {
                    --         keep_all_entries = false,
                    --         enable_in_context = function()
                    --             return true
                    --         end,
                    --         preselect_correct_word = true,
                    --     },
                    -- },
                    { name = "path", priority_weight = 30, group_index = 6 },
                    { name = "calc", priority_weight = 10, group_index = 7 },
                }, {
                    vim.tbl_deep_extend("force", buffer_source, {
                        keyword_length = 5,
                        max_item_count = 5,
                        option = {
                            keyword_length = 5,
                        },
                        priority_weight_weight = 60,
                        entry_filter = function(entry)
                            return not entry.exact
                        end,
                    }),
                }),
                sorting = {
                    priority_weight = 1,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.recently_used,
                        require("clangd_extensions.cmp_scores"),
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    {
                        name = "path",
                        option = {
                            trailing_slash = true,
                        },
                    },
                }, {
                    {
                        name = "async_path",
                        option = {
                            show_hidden_files_by_default = true,
                            trailing_slash = true,
                        },
                    },
                }, {
                    {
                        name = "cmdline",
                    },
                }, {
                    buffer_source,
                }, {
                    { name = "cmdline_history" },
                }),
            })
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    {
                        name = "path",
                        option = {
                            trailing_slash = true,
                        },
                    },
                }, {
                    {
                        name = "async_path",
                        option = {
                            show_hidden_files_by_default = true,
                            trailing_slash = true,
                        },
                    },
                }, { { name = "nvim_lsp_document_symbol" } }, {
                    buffer_source,
                }, {
                    { name = "cmdline_history" },
                }),
            })
            cmp.setup.cmdline("?", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    buffer_source,
                }, {
                    { name = "cmdline_history" },
                }),
            })
            cmp.setup.cmdline("@", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    {
                        name = "path",
                        option = {
                            trailing_slash = true,
                        },
                    },
                }, {
                    {
                        name = "async_path",
                        option = {
                            show_hidden_files_by_default = true,
                            trailing_slash = true,
                        },
                    },
                }, {
                    {
                        name = "cmdline",
                    },
                }, {
                    buffer_source,
                }),
            })
        end,
    },
}
