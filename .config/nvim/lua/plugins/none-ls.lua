return {
    {
        "jay-babu/mason-null-ls.nvim",
        enabled = false,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = { "stylua", "black", "isort", "shfmt", "clang_format", "mypy" },
                handlers = {},
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            local code_actions = null_ls.builtins.code_actions
            local diagnostics = null_ls.builtins.diagnostics
            local formatting = null_ls.builtins.formatting

            local diagnostics_config = {
                underline = true,
                virtual_text = true,
                signs = true,
                update_in_insert = false,
                severity_sort = true,
            }

            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            null_ls.setup({
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                local save_cursor = vim.fn.getpos(".")
                                vim.cmd([[%s/\s\+$//e]])
                                vim.fn.setpos(".", save_cursor)
                                vim.lsp.buf.format({
                                    async = false,
                                })
                            end,
                        })
                    end
                end,
                sources = {
                    formatting.stylua.with({
                        filetypes = { "lua" },
                        command = "stylua",
                        extra_args = {
                            "--indent-type",
                            "Spaces",
                            "--column-width",
                            "120",
                            "--indent-width",
                            "4",
                            "--line-endings",
                            "Unix",
                        },
                    }), -- lua formatting
                    formatting.black.with({
                        filetypes = { "python" },
                        command = "black",
                        extra_args = { "--line-length", "120" },
                    }), -- python formatting
                    formatting.isort.with({ filetypes = { "python" }, command = "isort" }), -- python import formatting
                    formatting.clang_format.with({ filetypes = { "c", "cpp" }, command = "clang-format" }),
                    formatting.shfmt.with({ filetypes = { "sh", "zsh" }, command = "shfmt" }),

                    diagnostics.mypy.with({
                        diagnostics_config = diagnostics_config,
                        diagnostics_format = "[#{c}] #{m} (#{s})",
                    }),
                },
            })
        end,
    },
}
