-- keymaps for tmux integration
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "CUSTOM: Move to the upper pane" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "CUSTOM: Move to the bottom pane" })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "CUSTOM: Move to the left pane" })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "CUSTOM: Move to the right pane" })

-- search keymaps
vim.keymap.set("n", "<leader>/", ":noh<CR>", { desc = "CUSTOM: Clear search highligths" })

-- Toggle showcased numbers
vim.keymap.set("n", "<leader>sr", function()
    vim.o.nu = false
    vim.opt.relativenumber = true
    vim.o.statuscolumn = "%C %s %r"
end, { desc = "CUSTOM: Showcase only relative numbers" })

vim.keymap.set("n", "<leader>sa", function()
    vim.opt.relativenumber = false
    vim.o.nu = true
    vim.o.statuscolumn = "%C %s %l"
end, { desc = "CUSTOM: Showcase only absolute numbers" })

vim.keymap.set("n", "<leader>sf", function()
    vim.o.nu = true
    vim.opt.relativenumber = true
    vim.o.statuscolumn = "%C %s %l %r"
end, { desc = "CUSTOM: Showcase all types of numbers numbers" })

-- Turn space and tab display on and off
vim.api.nvim_create_user_command("ToggleWhiteSpaceDisplay", function()
    if vim.o.list == true then
        vim.o.list = false
    else
        vim.o.list = true
    end
end, {})
