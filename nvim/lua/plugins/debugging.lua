-- These function may help later
local function add_debug_keymaps()
    local dap = require("dap")
    vim.keymap.set("n", "<leader>dr", dap.restart, { noremap = true })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { noremap = true })
    vim.keymap.set("n", "<F11>", dap.step_into, { noremap = true })
    vim.keymap.set("n", "<F10>", dap.step_over, { noremap = true })
    vim.keymap.set("n", "<F9>", dap.step_out, { noremap = true })
    vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { noremap = true })
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
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require("dapui").setup()
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            -- Dap ui subscribes to dap events
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

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
            vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { noremap = true })
            vim.keymap.set("n", "<leader>dl", dap.run_last, { noremap = true })
            vim.keymap.set("n", "<leader>dlb", dap.list_breakpoints, { noremap = true })
            vim.keymap.set("n", "<F5>", dap.continue, { noremap = true })
            vim.keymap.set("n", "<leader>dr", dap.restart, { noremap = true })
            vim.keymap.set("n", "<leader>dt", dap.terminate, { noremap = true })
            vim.keymap.set("n", "<F11>", dap.step_into, { noremap = true })
            vim.keymap.set("n", "<F10>", dap.step_over, { noremap = true })
            vim.keymap.set("n", "<F9>", dap.step_out, { noremap = true })
            vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { noremap = true })
        end,
    },
}
