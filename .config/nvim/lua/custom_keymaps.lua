-- search keymaps
vim.keymap.set("n", "<leader>/", ":noh<CR>", { desc = "CUSTOM: Clear search highligths" })

-- Turn space and tab display on and off
vim.api.nvim_create_user_command("ToggleWhiteSpaceDisplay", function()
    if vim.o.list == true then
        vim.o.list = false
    else
        vim.o.list = true
    end
end, {})

-- Making register handling easier
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "CUSTOM: Yank to + reg" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "CUSTOM: Paste from + reg" })
