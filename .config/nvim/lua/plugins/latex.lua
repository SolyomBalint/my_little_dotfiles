return {
    "lervag/vimtex",
    lazy = false, -- The documentation suggests to avoid lazy loading this one
    init = function()
        vim.g.vimtex_view_method = "zathura"
    end,
}
