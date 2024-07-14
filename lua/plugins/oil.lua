return {
    { "echasnovski/mini.icons",     version = false },
    { "nvim-tree/nvim-web-devicons" },
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true,
                },
            })
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    },
}
