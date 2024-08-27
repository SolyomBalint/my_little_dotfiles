return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("markview").setup({
                modes = { "n", "i", "v", "no", "c" }, -- Change these modes

                callbacks = {
                    on_enable = function(_, win)
                        vim.wo[win].conceallevel = 2
                        vim.wo[win].concealcursor = "c"
                    end,
                },
            })
            vim.keymap.set("n", "<C-m>", ":Markview toggleAll<CR>", { noremap = true })
        end,
    },
}
