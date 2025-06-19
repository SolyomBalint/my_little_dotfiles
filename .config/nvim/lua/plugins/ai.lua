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
            "stevearc/dressing.nvim",
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
}
