return {
    "lewis6991/hover.nvim",
    keys = {
        { "K",  desc = "HOVER: Load hover and show hover window" },
        { "gK", desc = "HOVER: Load hover and select hover provider" },
    },
    config = function()
        require("hover").setup({
            init = function()
                -- Require providers
                require("hover.providers.lsp")
                require("hover.providers.gh")
                require("hover.providers.gh_user")
                -- require('hover.providers.jira')
                require("hover.providers.dap")
                -- require('hover.providers.fold_preview')
                require("hover.providers.diagnostic")
                require("hover.providers.man")
                require("hover.providers.dictionary")
            end,
            preview_opts = {
                border = "single",
            },
            -- Whether the contents of a currently open hover window should be moved
            -- to a :h preview-window when pressing the hover keymap.
            preview_window = false,
            title = true,
            mouse_providers = {
                "LSP",
            },
            mouse_delay = 1000,
        })

        -- Setup keymaps
        vim.keymap.set("n", "K", require("hover").hover, { desc = "HOVER: Open hover window" })
        vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "HOVER: Hover select" })
        vim.keymap.set("n", "<C-p>", function()
            require("hover").hover_switch("previous")
        end, { desc = "HOVER: Previous source" })
        vim.keymap.set("n", "<C-n>", function()
            require("hover").hover_switch("next")
        end, { desc = "HOVER: Next source" })

        -- Mouse support
        -- vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
        -- vim.o.mousemoveevent = true
    end,
}
