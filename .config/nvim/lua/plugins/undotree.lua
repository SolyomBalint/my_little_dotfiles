return {
    "mbbill/undotree",
    keys = {
        { "<leader>ut", desc = "UNDOTREE: Load and toggle undotree" },
    },
    config = function()
        vim.opt.undodir = vim.fn.stdpath("config") .. "/.undo"
        vim.opt.undofile = true

        local undodir = vim.fn.stdpath("config") .. "/.undo"
        if vim.fn.isdirectory(undodir) == 0 then
            vim.fn.mkdir(undodir, "p")
        end

        vim.g.undotree_WindowLayout = 4
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "UNDOTREE: Toggle undotree" })
    end,
}
