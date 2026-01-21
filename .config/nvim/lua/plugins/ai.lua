return {
    {
        "yetone/avante.nvim",
        build = vim.fn.has("win32") ~= 0
                and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            or "make",
        event = "VeryLazy",
        version = false,
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            instructions_file = "avante.md",
            -- for example
            provider = "ollama",
            providers = {
                ollama = {
                    model = "mistral",
                    is_env_set = function()
                        return require("avante.providers.ollama").check_endpoint_alive()
                    end,
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",

            --- The below dependencies are optional,
            "ibhagwan/fzf-lua",
            "folke/snacks.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    },
}
