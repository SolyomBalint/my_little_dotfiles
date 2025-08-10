-- Adding lazy vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local function check_nvim_server_file()
    local server_file = "/tmp/nvim"
    local file_exists = vim.loop.fs_stat(server_file) ~= nil
    return file_exists
end

if not check_nvim_server_file() then
    vim.fn.serverstart("/tmp/nvim")
end

vim.filetype.add({
    extension = {
        tpp = "cpp",
        tcc = "cpp",
        ipp = "cpp",
        inl = "cpp",
    },
})

require("custom_functions")
require("custom_struct")
require("options")
require("custom_keymaps")
require("lazy").setup("plugins")

-- folding makes movement and insertion pretty slow, so I disabled it for now.
local isLoaded = package.loaded["ufo"] ~= nil

if not isLoaded then
    vim.o.nu = true
    vim.opt.relativenumber = true
    vim.o.statuscolumn = "%s %l %r"
end
