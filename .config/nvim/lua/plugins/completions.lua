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
            require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/LuaSnip/" })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
            { "hrsh7th/cmp-buffer" },
            {
                "uga-rosa/cmp-dictionary",
                lazy = true,
                config = function()
                    require("cmp_dictionary").setup({
                        paths = { "/usr/share/dict/words" },
                        exact_length = 4,
                    })
                end
            },
            { "f3fora/cmp-spell" },
            { "hrsh7th/cmp-nvim-lsp-document-symbol" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
            { "FelipeLema/cmp-async-path" },
            {
                "lukas-reineke/cmp-rg",
                lazy = true,
                enabled = function()
                    return vim.fn.executable("rg") == 1
                end,
            },
            { "hrsh7th/cmp-cmdline" },
            { "rcarriga/cmp-dap" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-calc" },
        },
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args) -- which snippet engine should be used
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = { -- how to completion window should look
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 150, group_index = 1 },
                    { name = "luasnip",  priority = 150, group_index = 1 }, -- For luasnip users.
                    {
                        name = "nvim_lua",
                        entry_filter = function()
                            if vim.bo.filetype ~= "lua" then
                                return false
                            end
                            return true
                        end,
                        priority = 150,
                        group_index = 1
                    },
                    { name = "cmp-nvim-lsp-document-symbol", priority = 100, group_index = 2 },
                    { name = "cmp-nvim-lsp-signature-help",  priority = 100, group_index = 2 },
                    {
                        name = "rg",
                        keyword_length = 5,
                        max_item_count = 5,
                        option = {
                            additional_arguments = "--smart-case --hidden --no-ignore-vcs",
                        },
                        priority = 80,
                        group_index = 3,
                    },
                    {

                        name = "dictionary",
                        keyword_length = 4,
                        priority = 50,
                        entry_filter = function()
                            local filetype = vim.bo.filetype
                            if filetype == "markdown" or filetype == "txt" or filetype == "tex" then
                                return true
                            end
                            return false
                        end,
                        group_index = 4
                    },
                    {
                        name = "spell",
                        priority = 50,
                        group_index = 4,
                        entry_filter = function()
                            local filetype = vim.bo.filetype
                            if filetype == "markdown" or filetype == "txt" or filetype == "tex" then
                                return true
                            end
                            return false
                        end,
                        option = {
                            keep_all_entries = false,
                            enable_in_context = function()
                                return true
                            end,
                            preselect_correct_word = true,
                        }
                    },
                    { name = "dap",        priority = 40, group_index = 5 },
                    { name = "async_path", priority = 30, group_index = 6 },
                    { name = "calc",       priority = 10, group_index = 7 },
                }, {
                    { name = "buffer" },
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
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                    { name = 'nvim_lsp_document_symbol' }
                }, {
                    { name = 'buffer' },
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                })
            })
        end,
    },
}
