return {
    {
        "olimorris/codecompanion.nvim",
        version = "^19.0.0",
        opts = {
            adapters = {
                http = {
                    ollama = function()
                        return require("codecompanion.adapters").extend(
                            "ollama",
                            {
                                schema = {
                                    model = {
                                        default = "mistral:7b",
                                    },
                                },
                            }
                        )
                    end,
                },
            },
            display = {
                chat = {
                    window = {
                        layout = "horizontal",
                        height = 0.2,
                    },
                },

                cli = {
                    window = {
                        layout = "horizontal",
                        height = 0.2,
                    },
                },
            },
            interactions = {
                chat = {
                    adapter = {
                        name = "ollama",
                        model = "mistral:7b",
                    },
                },
                inline = {
                    adapter = {
                        name = "ollama",
                        model = "mistral:7b",
                    },
                },
                cmd = {
                    adapter = {
                        name = "ollama",
                        model = "mistral:7b",
                    },
                },
                background = {
                    adapter = {
                        name = "ollama",
                        model = "mistral:7b",
                    },
                },
                cli = {
                    agent = "claude_code",
                    agents = {
                        claude_code = {
                            cmd = "claude",
                            args = {},
                            description = "Claude Code CLI",
                            provider = "terminal",
                        },
                    },
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
}
