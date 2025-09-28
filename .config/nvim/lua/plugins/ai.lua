return {
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        opts = {
            port_range = { min = 10000, max = 65535 },
            auto_start = true,
            log_level = "info",
            terminal_cmd = nil, -- Custom terminal command (default: "claude")
            -- For local installations: "~/.claude/local/claude"
            -- For native binary: use output from 'which claude'

            focus_after_send = false,
            git_repo_cwd = true,

            -- Selection Tracking
            track_selection = true,
            visual_demotion_delay_ms = 50,

            -- Terminal Configuration
            terminal = {
                split_width_percentage = 0.30,
                provider = "snacks",
                auto_close = true,
                snacks_win_opts = {
                    position = "bottom",
                    height = 0.4,
                    width = 1.0,
                    border = "single",
                },
            },

            -- Diff Integration
            diff_opts = {
                auto_close_on_accept = true,
                vertical_split = false,
                open_in_current_tab = true,
                keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
            },
        },
        keys = {
            { "<leader>a", nil, desc = "AI/Claude Code" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
            {
                "<leader>ar",
                "<cmd>ClaudeCode --resume<cr>",
                desc = "Resume Claude",
            },
            {
                "<leader>aC",
                "<cmd>ClaudeCode --continue<cr>",
                desc = "Continue Claude",
            },
            {
                "<leader>am",
                "<cmd>ClaudeCodeSelectModel<cr>",
                desc = "Select Claude model",
            },
            {
                "<leader>ab",
                "<cmd>ClaudeCodeAdd %<cr>",
                desc = "Add current buffer",
            },
            {
                "<leader>as",
                "<cmd>ClaudeCodeSend<cr>",
                mode = "v",
                desc = "Send to Claude",
            },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
            },
            -- Diff management
            {
                "<leader>aa",
                "<cmd>ClaudeCodeDiffAccept<cr>",
                desc = "Accept diff",
            },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
    },
    {
        "piersolenski/wtf.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            provider = "copilot",
            popup_type = "popup",
            search_engine = "google",
        },
        keys = {
            {
                "<leader>wd",
                mode = { "n", "x" },
                function()
                    require("wtf").diagnose()
                end,
                desc = "Debug diagnostic with AI",
            },
            {
                "<leader>wf",
                mode = { "n", "x" },
                function()
                    require("wtf").fix()
                end,
                desc = "Fix diagnostic with AI",
            },
            {
                mode = { "n" },
                "<leader>ws",
                function()
                    require("wtf").search()
                end,
                desc = "Search diagnostic with Google",
            },
            {
                mode = { "n" },
                "<leader>wh",
                function()
                    require("wtf").history()
                end,
                desc = "Populate the quickfix list with previous chat history",
            },
            {
                mode = { "n" },
                "<leader>wg",
                function()
                    require("wtf").grep_history()
                end,
                desc = "Grep previous chat history with Telescope",
            },
        },
    },
}
