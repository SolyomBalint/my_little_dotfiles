local jdtls = require("jdtls")

local on_attach = function() -- TODO this is a duplicate, but it's good enough for now
	vim.keymap.set("n", "I", vim.lsp.buf.hover, { noremap = true })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { noremap = true })
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { noremap = true })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true })

	vim.keymap.set("n", "<leader>ic", ":Telescope lsp_incoming_calls<CR>", { noremap = true })
	vim.keymap.set("n", "<leader>ot", ":Telescope lsp_outgoing_calls<CR>", { noremap = true })
	vim.keymap.set("n", "<leader>rf", ":Telescope lsp_references<CR>", { noremap = true })
	vim.keymap.set("n", "<leader>td", ":Telescope lsp_type_definitions<CR>", { noremap = true })
	vim.keymap.set("n", "<leader>ds", ":Telescope lsp_document_symbols<CR>", { noremap = true })
	vim.keymap.set("n", "<leader>tp", vim.lsp.buf.typehierarchy, { noremap = true })

	-- jdtls specific keymaps

	vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, { noremap = true })
	vim.keymap.set("n", "<leader>jev", jdtls.extract_variable, { noremap = true })
	vim.keymap.set("n", "<leader>jec", jdtls.extract_constant, { noremap = true })
	vim.keymap.set("v", "<leader>jm", jdtls.extract_method, { noremap = true })
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local home_dir = vim.env.HOME

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local bundles = {
	vim.fn.glob(
		home_dir
			.. "/java-debug/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.0.jar",
		1
	),
}
vim.list_extend(
	bundles,
	vim.split(
		vim.fn.glob(
			home_dir .. "/java-test/vscode-java-test/server/org.eclipse.jdt.junit5.runtime_1.1.100.v20220907-0450.jar",
			1
		),
		"\n"
	)
)
local workspace_dir = home_dir .. "/projects/java_projects/nvim/" .. project_name
local config = {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = {

		"/usr/lib/jvm/java-17-openjdk-amd64/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-jar",
		home_dir .. "/eclipse-jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",

		"-configuration",
		home_dir .. "/eclipse-jdtls/config_linux",

		"-data",
		workspace_dir,
	},

	root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

	settings = {
		java = {
			format = {
				settings = {
					-- url = "/.local/share/eclipse/eclipse-java-google-style.xml",
					-- profile = "GoogleStyle",
				},
			},
		},
	},

	init_options = {
		bundles = bundles,
	},
}
jdtls.start_or_attach(config)
