return {

    { "echasnovski/mini.icons", lazy = true, version = false },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                use_default_keymaps = false,
                keymaps = {
                    ["g?"] = "actions.show_help",
                    ["<CR>"] = "actions.select",
                    ["<leader>wv"] = {
                        "actions.select",
                        opts = { vertical = true },
                        desc = "Open the entry in a vertical split",
                    },
                    ["<leader>wh"] = {
                        "actions.select",
                        opts = { horizontal = true },
                        desc = "Open the entry in a horizontal split",
                    },
                    ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = "actions.close",
                    ["<C-l>"] = "actions.refresh",
                    ["-"] = "actions.parent",
                    ["_"] = "actions.open_cwd",
                    ["`"] = "actions.cd",
                    ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
                    ["gs"] = "actions.change_sort",
                    ["gx"] = "actions.open_external",
                    ["g."] = "actions.toggle_hidden",
                    ["g\\"] = "actions.toggle_trash",
                },
                view_options = {
                    show_hidden = true,
                },
            })
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "OIL: Open parent directory" })
        end,
    },
}
