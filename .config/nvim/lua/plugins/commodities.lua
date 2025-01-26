local is_dim_enabled = false

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
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        enabled = false,
        init = function()
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        end,
        config = function()
            local ftMap = {
                vim = "indent",
                python = { "indent" },
                git = "",
            }
            require("ufo").setup({
                fold_virt_text_handler = handler,
                open_fold_hl_timeout = 150,
                close_fold_kinds_for_ft = {
                    default = { "imports", "comment" },
                    json = { "array" },
                    c = { "comment", "region" },
                },
                preview = {
                    win_config = {
                        border = { "", "─", "", "", "", "─", "", "" },
                        winhighlight = "Normal:Folded",
                        winblend = 0,
                    },
                    mappings = {
                        scrollU = "<C-u>",
                        scrollD = "<C-d>",
                        jumpTop = "[",
                        jumpBot = "]",
                    },
                },
                provider_selector = function(bufnr, filetype, buftype)
                    return { "treesitter", "indent" }
                end,
            })
            vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "UFO: Open all folds" })
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "UFO: Close all folds" })
            vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "UFO: Open all folds except kind" })
            vim.keymap.set("n", "zm", function()
                require("ufo").closeFoldsWith(1)
            end, { desc = "UFO: Close all folds below level 1" })
            vim.keymap.set("n", "K", function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, { desc = "UFO: Closed folds preview" })
        end,
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
}
