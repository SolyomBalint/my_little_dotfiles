-- keymaps for tmux integration
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "CUSTOM: Move to the upper pane" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "CUSTOM: Move to the bottom pane" })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "CUSTOM: Move to the left pane" })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "CUSTOM: Move to the right pane" })

-- search keymaps
vim.keymap.set("n", "<leader>/", ":noh<CR>", { desc = "CUSTOM: Clear search highligths" })
