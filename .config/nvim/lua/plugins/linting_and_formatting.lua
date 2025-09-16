return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                glsl = { "clang-format" },
                nix = { "nixfmt" },
                sh = { "shfmt" },
                zsh = { "shfmt" },
                yaml = { "prettier" },
                json = { "prettier" },
                css = { "prettier" },
                markdown = { "prettier" },
                typst = { "typstyle" },
            },

            default_format_opts = {
                lsp_format = "fallback",
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 2000, lsp_format = "fallback" }
            end,
            notify_on_error = true,
            notify_no_formatters = true,
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2" },
                },
                stylua = {
                    -- inherit = false, overwrite whole cmd
                    prepend_args = {
                        "--indent-type",
                        "Spaces",
                        "--column-width",
                        "80",
                        "--indent-width",
                        "4",
                        "--line-endings",
                        "Unix",
                    },
                },
                black = {
                    prepend_args = {
                        "--line-length",
                        "80",
                    },
                },
            },
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, {
                desc = "Disable autoformat-on-save",
                bang = true,
            })
            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, {
                desc = "Re-enable autoformat-on-save",
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        ft = { "python" },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                python = { "mypy" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
