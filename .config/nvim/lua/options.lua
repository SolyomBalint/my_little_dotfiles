-- Setting tabs
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Show tabs and spaces
-- Only show dots at the start of lines (for indentation)
vim.opt.list = false
vim.opt.listchars = {
    tab = "→ ", -- Show tab characters
    lead = "·", -- Only show leading spaces as dots
    trail = " ", -- Do not show trailing spaces as dots
    eol = " ", -- Do not show end-of-line markers
}

-- Turning default file browser off
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Turning file numbering on
vim.opt.relativenumber = true

-- Setting the system clipboard
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- spell checking
vim.opt.spelllang = "en_gb"
vim.opt.spell = true

-- adding colour columns
vim.o.colorcolumn = "80,120"

-- setting line length limit
vim.o.textwidth = 80

-- Setting undo persistency
vim.opt.undofile = true

-- Turn off base virtual text
vim.diagnostic.config({
    virtual_text = false,
})

-- Obisdian settings
vim.opt.conceallevel = 1
