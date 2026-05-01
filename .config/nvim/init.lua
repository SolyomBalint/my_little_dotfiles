-- Adding lazy vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local function check_nvim_server_file()
    local server_file = "/tmp/nvim"
    local file_exists = vim.uv.fs_stat(server_file) ~= nil
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

require("custom_struct")
require("options")
require("custom_keymaps")

-- Call this after options are loaded, otherwise keymaps may be faulty. Refer to lazy.nvim docs
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
})
