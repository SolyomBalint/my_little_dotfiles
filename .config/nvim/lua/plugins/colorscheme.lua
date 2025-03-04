-- these two function has to be called after coloscheme is set up
local function turn_off_semantics_highlighting()
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
    end
end

local function fix_semantic_highlighting()
    local links = {
        ["@lsp.type.namespace"] = "@namespace",
        ["@lsp.type.type"] = "@type",
        ["@lsp.type.class"] = "@type",
        ["@lsp.type.enum"] = "@type",
        ["@lsp.type.interface"] = "@type",
        ["@lsp.type.struct"] = "@structure",
        ["@lsp.type.parameter"] = "@parameter",
        ["@lsp.type.variable"] = "@variable",
        ["@lsp.type.property"] = "@property",
        ["@lsp.type.enumMember"] = "@constant",
        ["@lsp.type.function"] = "@function",
        ["@lsp.type.method"] = "@method",
        ["@lsp.type.macro"] = "@macro",
        ["@lsp.type.decorator"] = "@function",
    }
    for newgroup, oldgroup in pairs(links) do
        vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
    end
end

local semantics_enabled = true

local function toggle_semantics_highlighting()
    if semantics_enabled then
        -- Turn off semantic highlighting
        for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
            vim.api.nvim_set_hl(0, group, {})
        end
    else
        -- -- Re-enable semantic highlighting
        -- for _, client in pairs(vim.lsp.get_clients()) do
        --     vim.lsp.buf.attach(client)
        -- end
        -- Optional: reload color scheme to fully restore all highlights
        vim.cmd("colorscheme " .. vim.g.colors_name)
    end
    semantics_enabled = not semantics_enabled
end

vim.api.nvim_create_user_command("ToggleSemanticsHighlight", function()
    toggle_semantics_highlighting()
end, {})

return {
    {
        "rebelot/kanagawa.nvim",
        dependencies = { "HiPhish/rainbow-delimiters.nvim" },
        lazy = false,
        priority = 1000,
        config = function()
            -- Default options:
            require("kanagawa").setup({
                compile = false, -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false, -- do not set background color
                dimInactive = false, -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                colors = { -- add/modify theme and palette colors
                    palette = {},
                    theme = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
                theme = "wave", -- Load "wave" theme when 'background' option is not set
                background = { -- map the value of 'background' option to a theme
                    dark = "dragon", -- try "dragon" !
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },
                        String = { fg = "#98BB6C", italic = true },
                    }
                end,
            })

            -- setup must be called before loading
            vim.cmd("colorscheme kanagawa")

            -- check if this is bad in c++ as well, only leave it in then
            -- turn_off_semantics_highlighting()

            -- fix_semantic_highlighting()
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            -- This module contains a number of default definitions
            local rainbow_delimiters = require("rainbow-delimiters")

            ---@type rainbow_delimiters.config
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = function(bufnr)
                        -- Disabled for very large files, global strategy for large files,
                        -- local strategy otherwise
                        local line_count = vim.api.nvim_buf_line_count(bufnr)
                        if line_count > 5000 then
                            return nil
                        end
                        return rainbow_delimiters.strategy["global"]
                    end,
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                priority = {
                    [""] = 110,
                    lua = 210,
                },
                highlight = {
                    "KanagawaDelimiterLightGrey", -- Outermost delimiter
                    "KanagawaDelimiterDeepPurple",
                    "KanagawaDelimiterBrightCyan",
                    "KanagawaDelimiterYellow",
                    "KanagawaDelimiterTeal",
                    "KanagawaDelimiterRed",
                    "KanagawaDelimiterOrange", -- Innermost delimiter
                },
            }

            vim.api.nvim_create_user_command("ToggleBracketHighlight", function()
                rainbow_delimiters.toggle(0)
            end, {})
        end,
    },
}
