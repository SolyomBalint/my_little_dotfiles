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

local function isModuleAvailable(name)
    if package.loaded[name] then
        return true
    else
        for _, searcher in ipairs(package.searchers or package.loaders) do
            local loader = searcher(name)
            if type(loader) == "function" then
                package.preload[name] = loader
                return true
            end
        end
        return false
    end
end

if isModuleAvailable("local_additions") then
    require("local_additions")
end
