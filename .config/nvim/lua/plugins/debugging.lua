return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
        },
        config = function()
            -- Dap ui subscribes to dap events
            local dap = require("dap")

            -- gdb adapter setup
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = {
                    "--interpreter=dap",
                    "--eval-command",
                    "set print pretty on",
                },
            }

            --C/C++ native debugging setup
            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input(
                            "Path to executable: ",
                            vim.fn.getcwd() .. "/",
                            "file"
                        )
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }

            dap.configurations.c = dap.configurations.cpp
            vim.keymap.set(
                "n",
                "<leader>drl",
                dap.run_last,
                { noremap = true, desc = "DAP: Run last session" }
            )
            vim.keymap.set("n", "<F5>", dap.continue, {
                noremap = true,
                desc = "DAP: Run debugger and read launch.json",
            })
        end,
    },
    {
        "Weissle/persistent-breakpoints.nvim",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("persistent-breakpoints").setup({
                load_breakpoints_event = { "BufReadPost" },
            })
            local pb = require("persistent-breakpoints.api")
            vim.keymap.set("n", "<Leader>db", pb.toggle_breakpoint, {
                noremap = true,
                desc = "PERSBP: Toggle persistent breakpoint",
            })
            vim.keymap.set("n", "<Leader>cb", pb.set_conditional_breakpoint, {
                noremap = true,
                desc = "PERSBP: Toggle persistent conditional breakpoint",
            })
            vim.keymap.set(
                "n",
                "<leader>cab",
                pb.clear_all_breakpoints,
                { noremap = true, desc = "PERSBP: Clear breakpoints" }
            )
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        enabled = true,
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("dap-python").setup("python")
        end,
    },
    {
        "igorlfs/nvim-dap-view",
        -- let the plugin lazy load itself
        lazy = false,
        version = "1.*",
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {
            virtual_text = {
                enabled = true,
            },
            auto_toggle = "keep_terminal",
        },
    },
}
