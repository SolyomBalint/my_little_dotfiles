return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        vim.filetype.add({
            extension = {
                hip = "cuda",
            },
        })
        config.setup({
            ignore_install = { "latex" },
            ensure_installed = {
                "html",
                "regex",
                "markdown",
                "markdown_inline",
            },
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true },
        })
    end,
}
