return {
    { "cohama/lexima.vim" },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        config = function()
            require("Comment").setup({})
        end,
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    project = {
                        action = "FzfLua files cwd="
                    },
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                        {
                            desc = ' config',
                            group = "@property",
                            action = function() require('fzf-lua').files({ cwd = vim.fn.expand("~/my_little_dotfiles/") }) end,
                            key = 'c'
                        },
                        {
                            desc = ' NeoGit',
                            group = "@property",
                            action = function() require('neogit').open() end,
                            key = 'g'
                        }
                    },
                },
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },

}
