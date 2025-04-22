local is_dim_enabled = false
local highlight_group = {
    "KanagawaDelimiterLightGrey", -- Outermost delimiter Check out custom files
    "KanagawaDelimiterDeepPurple",
    "KanagawaDelimiterBrightCyan",
    "KanagawaDelimiterYellow",
    "KanagawaDelimiterTeal",
    "KanagawaDelimiterRed",
    "KanagawaDelimiterOrange", -- Innermost delimiter
}

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

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
        "zeioth/garbage-day.nvim",
        dependencies = "neovim/nvim-lspconfig",
        event = "VeryLazy",
        opts = {
            wakeup_delay = 500,
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = {
                enabled = true,
                notify = true,
                size = 1.5 * 1024 * 1024, -- 1.5MB
            },
            input = {
                enabled = true,
                icon = " ",
                icon_hl = "SnacksInputIcon",
                icon_pos = "left",
                prompt_pos = "title",
                win = { style = "input" },
                expand = true,
            },
            dashboard = {
                enabled = true,
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Recent Files",
                        section = "recent_files",
                        indent = 2,
                        padding = 1,
                    },
                    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Diff",
                        section = "terminal",
                        enabled = function()
                            return Snacks.git.get_root() ~= nil
                        end,
                        cmd = "git --no-pager diff --stat -B -M -C",
                        height = 10,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                    {
                        pane = 2,
                        icon = "󰻫 ",
                        title = "Untracked Files",
                        section = "terminal",
                        enabled = function()
                            return Snacks.git.get_root() ~= nil
                        end,
                        cmd = "git ls-files --others --exclude-standard",
                        height = 10,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                    { section = "startup" },
                },
            },
            dim = { enabled = true },
            git = { enabled = true },
            quickfile = { enabled = true },
            scroll = { enabled = true },
            indent = {
                enabled = true,
                hl = highlight_group,
                scope = {
                    hl = highlight_group,
                },
                animate = {
                    enabled = true,
                    style = "up_down",
                },
            },
        },
        config = function(_, opts)
            local snacks = require("snacks")
            snacks.setup(opts)

            vim.keymap.set("n", "<C-s>d", function()
                if is_dim_enabled then
                    snacks.dim.disable()
                    is_dim_enabled = false
                    return
                end
                snacks.dim.enable()
                is_dim_enabled = true
            end, { desc = "SNACKS: activate dim" })
            vim.keymap.set("n", "<C-s>gb", snacks.git.blame_line, { desc = "SNACKS: Git blame" })
        end,
    },
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
