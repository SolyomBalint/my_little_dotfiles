return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        enabled = true,
        -- lazy = false,
        keys = {
            { "<leader>aa", desc = "AVANTE: Load avante, and open chat" },
        },
        version = false,
        opts = {},
        build = "make",
        dependencies = {
            "stevearc/snacks.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
        },
        config = function()
            vim.opt.laststatus = 3
            require("copilot").setup({})
            require("avante").setup({
                provider = "copilot",
                system_prompt = function()
                    local hub = require("mcphub").get_hub_instance()
                    return hub and hub:get_active_servers_prompt() or ""
                end,
                custom_tools = function()
                    return {
                        require("mcphub.extensions.avante").mcp_tool(),
                    }
                end,
                disabled_tools = {
                    "list_files",
                    "search_files",
                    "read_file",
                    "create_file",
                    "rename_file",
                    "delete_file",
                    "create_dir",
                    "rename_dir",
                    "delete_dir",
                    "bash",
                },
            })
        end,
    },
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "bundled_build.lua",
        config = function()
            require("mcphub").setup({
                config = vim.fn.expand("~/.config/mcphub/servers.json"),
                port = 37373,
                shutdown_delay = 60 * 10 * 000,
                use_bundled_binary = true,
                mcp_request_timeout = 60000,

                auto_approve = false,
                auto_toggle_mcp_servers = true,
                extensions = {
                    avante = {
                        make_slash_commands = true,
                    },
                },
            })
        end,
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
