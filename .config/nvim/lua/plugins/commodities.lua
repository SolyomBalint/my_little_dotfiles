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
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            -- This module contains a number of default definitions
            local rainbow_delimiters = require 'rainbow-delimiters'
            local setColours = function(group, opts)
                vim.api.nvim_set_hl(0, group, opts)
            end
            setColours('KanagawaDelimiterLightGrey', { default = true, fg = '#9CABCA', ctermfg = 'LightGrey' }) -- Light Grey
            setColours('KanagawaDelimiterDeepPurple', { default = true, fg = '#957FB8', ctermfg = 'Magenta' })  -- Spring Violet
            setColours('KanagawaDelimiterBrightCyan', { default = true, fg = '#6A9589', ctermfg = 'Cyan' })     -- Light Blue
            setColours('KanagawaDelimiterTeal', { default = true, fg = '#7AA89F', ctermfg = 'Cyan' })           -- Teal
            setColours('KanagawaDelimiterYellow', { default = true, fg = '#DCD7BA', ctermfg = 'Yellow' })       -- Yellow
            setColours('KanagawaDelimiterRed', { default = true, fg = '#E46876', ctermfg = 'Red' })             -- Red
            setColours('KanagawaDelimiterOrange', { default = true, fg = '#FF9E3B', ctermfg = 'Yellow' })       -- Yellow

            ---@type rainbow_delimiters.config
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = function(bufnr)
                        -- Disabled for very large files, global strategy for large files,
                        -- local strategy otherwise
                        local line_count = vim.api.nvim_buf_line_count(bufnr)
                        if line_count > 5000 then
                            return nil
                        end
                        return rainbow_delimiters.strategy['global']
                    end
                    ,
                    vim = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                priority = {
                    [''] = 110,
                    lua = 210,
                },
                highlight = {
                    'KanagawaDelimiterLightGrey', -- Outermost delimiter
                    'KanagawaDelimiterDeepPurple',
                    'KanagawaDelimiterBrightCyan',
                    'KanagawaDelimiterYellow',
                    'KanagawaDelimiterTeal',
                    'KanagawaDelimiterRed',
                    'KanagawaDelimiterOrange', -- Innermost delimiter
                },
            }

            vim.api.nvim_create_user_command("ToggleBracketHighlight", function()
                rainbow_delimiters.toggle(0)
            end, {})
        end
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
                        },
                        {
                            desc = ' Browse cwd',
                            group = "@property",
                            action = function() require('fzf-lua').files() end,
                            key = 's'
                        }
                    },
                },
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },

}
