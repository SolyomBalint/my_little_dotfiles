return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons', 'nvim-tree/nvim-web-devicons' }, -- if you use standalone mini plugins
        config = function()
            vim.keymap.set("n", "<C-m>", ":RenderMarkdown toggle<CR>", { noremap = true })
        end
    }
}
