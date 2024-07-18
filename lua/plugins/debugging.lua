--https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation this is where I can find debugger installiations
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
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
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = function()
					local registry = require("mason-registry")
					local pkg = registry.get_package("codelldb")
					return pkg:get_install_path()
				end,
				args = { "--port", "${port}" },
			},
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		dap.configurations.c = dap.configurations.cpp
		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {noremap = true})
		vim.keymap.set("n", "<Leader>dc", dap.continue, {noremap = true})
        vim.keymap.set("n", "<leader>di", dap.step_into, {noremap = true})
        vim.keymap.set("n", "<leader>do", dap.step_over, {noremap = true})
	end,
}
