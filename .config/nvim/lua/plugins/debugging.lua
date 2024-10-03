-- These function may help later

local keys_registered = false

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
            "williamboman/mason.nvim",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            -- Dap ui subscribes to dap events
            local dap, dapui = require("dap"), require("dapui")
            dap.set_log_level('DEBUG')
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
            vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { noremap = true })
            vim.keymap.set("n", "<Leader>cb", function ()
                dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { noremap = true })
            vim.keymap.set("n", "<leader>drl", dap.run_last, { noremap = true })
            vim.keymap.set("n", "<F5>",
                function()
                    if vim.fn.filereadable(vim.fn.expand("~/.config/custom/launch.json")) then
                        require('dap.ext.vscode').load_launchjs(vim.fn.expand("~/.config/custom/launch.json"), {})
                    end
                    dap.continue()
                end,
                { noremap = true })
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("dap-python").setup("python")
        end
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "rcarriga/nvim-dap-ui", "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-dap-virtual-text").setup {
                enabled = true,                     -- enable this plugin (the default)
                enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                show_stop_reason = true,            -- show stop reason when stopped for exceptions
                commented = false,                  -- prefix virtual text with comment string
                only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
                all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
                clear_on_continue = false,          -- clear virtual text on "continue" (might cause flickering when stepping)
                --- A callback that determines how a variable is displayed or whether it should be omitted
                --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
                --- @param buf number
                --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
                --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
                --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
                --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
                display_callback = function(variable, buf, stackframe, node, options)
                    -- by default, strip out new line characters
                    if options.virt_text_pos == 'inline' then
                        return ' = ' .. variable.value:gsub("%s+", " ")
                    else
                        return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
                    end
                end,
                -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
                virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

                -- experimental features:
                all_frames = false,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
                virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
                virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
                -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
            }
        end
    },
}
