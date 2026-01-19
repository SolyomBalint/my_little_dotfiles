return {
    {
        "stevearc/aerial.nvim",
        opts = {},
        keys = { { "<leader>at", desc = "AERIAL: Load and toggle" } },
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("aerial").setup({
                show_guides = true,
                -- optionally use on_attach to set keymaps when aerial has attached to a buffer
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with '{' and '}'
                    vim.keymap.set(
                        "n",
                        "{",
                        "<cmd>AerialPrev<CR>",
                        { buffer = bufnr }
                    )
                    vim.keymap.set(
                        "n",
                        "}",
                        "<cmd>AerialNext<CR>",
                        { buffer = bufnr }
                    )
                end,
            })
            vim.cmd("nmap <silent> <leader>af <cmd>call aerial#fzf()<cr>")
            -- You probably also want to set a keymap to toggle aerial
            vim.keymap.set("n", "<leader>at", "<cmd>AerialToggle! right<CR>")
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xdp",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "TROUBLE: Diagnostics",
            },
            {
                "<leader>xdc",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "TROUBLE: Buffer Diagnostics",
            },
            {
                "<leader>xs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "TROUBLE: Symbols",
            },
            {
                "<leader>xl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "TROUBLE: LSP Definitions / references / ...",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "TROUBLE: Location List",
            },
            {
                "<leader>xq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "TROUBLE: Quickfix List",
            },
        },
    },
}
