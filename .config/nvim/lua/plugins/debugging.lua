-- These function may help later

local keys_registered = false

local function add_debug_keymaps()
    local dap = require("dap")
    vim.keymap.set("n", "<leader>dr", dap.restart, { noremap = true, desc = "DAP: Restart current session" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { noremap = true, desc = "DAP: Terninate current session" })
    vim.keymap.set("n", "<F11>", dap.step_into, { noremap = true, desc = "DAP: Step into function at cursor" })
    vim.keymap.set("n", "<F10>", dap.step_over, { noremap = true, desc = "DAP: Step over cursor" })
    vim.keymap.set("n", "<F9>", dap.step_out, { noremap = true, desc = "DAP: Step out of current cursor" })
    vim.keymap.set(
        "n",
        "<leader>dc",
        dap.run_to_cursor,
        { noremap = true, desc = "DAP: Run debugging sessios to cursor" }
    )
end

local function remove_debug_keymaps()
    vim.keymap.del("n", "<leader>dr")
    vim.keymap.del("n", "<leader>dt")
    vim.keymap.del("n", "<F11>")
    vim.keymap.del("n", "<F10>")
    vim.keymap.del("n", "<F9>")
    vim.keymap.del("n", "<leader>dc")
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
        },
        config = function()
            -- Dap ui subscribes to dap events
            local dap, dapui = require("dap"), require("dapui")
            dap.set_log_level("DEBUG")
            dap.listeners.before.attach.dapui_config = function()
                if not keys_registered then
                    add_debug_keymaps()
                    keys_registered = true
                end
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                if not keys_registered then
                    add_debug_keymaps()
                    keys_registered = true
                end
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                if keys_registered then
                    remove_debug_keymaps()
                    keys_registered = false
                end
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                if keys_registered then
                    remove_debug_keymaps()
                    keys_registered = false
                end
                dapui.close()
            end

            -- local mason_registry = require("mason-registry")
            -- gdb adapter setup
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
            }

            --C/C++ native debugging setup
            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
                {
                    name = "Select and attach to process",
                    type = "gdb",
                    request = "attach",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    pid = function()
                        local name = vim.fn.input("Executable name (filter): ")
                        return require("dap.utils").pick_process({ filter = name })
                    end,
                    cwd = "${workspaceFolder}",
                },
                {
                    name = "Attach to gdbserver :1234",
                    type = "gdb",
                    request = "attach",
                    target = "localhost:1234",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                },
            }

            dap.configurations.c = dap.configurations.cpp
            vim.keymap.set("n", "<leader>drl", dap.run_last, { noremap = true, desc = "DAP: Run last session" })
            vim.keymap.set(
                "n",
                "<F5>",
                dap.continue,
                { noremap = true, desc = "DAP: Run debugger and read launch.json" }
            )
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
            vim.keymap.set(
                "n",
                "<Leader>db",
                pb.toggle_breakpoint,
                { noremap = true, desc = "PERSBP: Toggle persistent breakpoint" }
            )
            vim.keymap.set(
                "n",
                "<Leader>cb",
                pb.set_conditional_breakpoint,
                { noremap = true, desc = "PERSBP: Toggle persistent conditional breakpoint" }
            )
            vim.keymap.set(
                "n",
                "<leader>cab",
                pb.clear_all_breakpoints,
                { noremap = true, desc = "PERSBP: Clear breakpoints" }
            )
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dapui = require("dapui")
            dapui.setup({
                layouts = {
                    {
                        elements = {
                            {
                                id = "scopes",
                                size = 0.5,
                            },
                            {
                                id = "breakpoints",
                                size = 0.5,
                            },
                        },
                        position = "left",
                        size = 40,
                    },
                    {
                        elements = {
                            {
                                id = "console",
                                size = 1.0,
                            },
                        },
                        position = "bottom",
                        size = 10,
                    },
                },
            })

            vim.keymap.set("n", "<leader>duf", dapui.float_element, { desc = "DAPUI: Open float windows" })
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("dap-python").setup("python")
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "rcarriga/nvim-dap-ui", "nvim-treesitter/nvim-treesitter" },
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
                display_callback = function(variable, buf, stackframe, node, options)
                    if options.virt_text_pos == "inline" then
                        return " = " .. variable.value:gsub("%s+", " ")
                    else
                        return variable.name .. " = " .. variable.value:gsub("%s+", " ")
                    end
                end,
                virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

                all_frames = false,
                virt_lines = false,
                virt_text_win_col = nil,
            })
        end,
    },
}
