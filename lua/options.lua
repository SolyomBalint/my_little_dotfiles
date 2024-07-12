-- Setting tabs
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Turning default file browser off
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Turning file numbering on
vim.opt.nu = true
vim.opt.relativenumber = true
vim.o.statuscolumn = "%s %l %r "

-- Setting the system clipboard
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = " "

-- keymaps for tmux integration
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
