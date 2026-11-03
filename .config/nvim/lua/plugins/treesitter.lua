return {
    "romus204/tree-sitter-manager.nvim",
    lazy = false,
    config = function()
        vim.filetype.add({
            extension = {
                hip = "cuda",
            },
        })
        require("tree-sitter-manager").setup({
            ensure_installed = {
                "html",
                "regex",
                "markdown",
                "markdown_inline",
            },
            auto_install = true,
            highlight = true,
            -- VimTeX needs its own syntax engine (conceal, math zone detection)
            nohighlight = { "latex" },
        })
    end,
}
