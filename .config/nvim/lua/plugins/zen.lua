return {
    "folke/zen-mode.nvim",
    keys = { { "<leader>z", desc = "ZEN: Load and open zen" } },
    config = function()
        local zen = require("zen-mode")

        zen.setup({
            window = {
                backdrop = 1,
                width = 200,
            },
            plugins = {
                tmux = { enabled = true },
            },
        })
        vim.keymap.set("n", "<leader>z", function()
            zen.toggle({ width = 1 })
        end, { desc = "ZEN: toggle zen mode" })
    end,
}
