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
        lazy = false,
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {
            auto_toggle = true,
            follow_tab = false,
        },
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            require("nvim-dap-virtual-text").setup({
                enabled = true,
                enabled_commands = true,
                highlight_changed_variables = true,
                highlight_new_as_changed = false,
                show_stop_reason = true,
                commented = false,
                only_first_definition = true,
                all_references = false,
                clear_on_continue = false,
                --- @param variable Variable
                --- @param buf number
                --- @param stackframe dap.StackFrame
                --- @param node userdata
                --- @param options nvim_dap_virtual_text_options
                --- @return string|nil
                display_callback = function(
                    variable,
                    buf,
                    stackframe,
                    node,
                    options
                )
                    -- by default, strip out new line characters
                    if options.virt_text_pos == "inline" then
                        return " = " .. variable.value:gsub("%s+", " ")
                    else
                        return variable.name
                            .. " = "
                            .. variable.value:gsub("%s+", " ")
                    end
                end,
                virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline"
                    or "eol",

                all_frames = false,
                virt_lines = false,
                virt_text_win_col = nil,
            })
        end,
    },
}
