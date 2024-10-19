local jdtls = require("jdtls")
local fzf = require("fzf-lua")

local on_attach = function()
    vim.keymap.set("n", "I", vim.lsp.buf.hover, { noremap = true, desc = "LSP: Hover" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, desc = "LSP: Go to definition" })
    vim.keymap.set(
        "n",
        "<leader>wa",
        vim.lsp.buf.add_workspace_folder,
        { noremap = true, desc = "LSP: Add workspace folder" }
    )
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, desc = "LSP: Go to declaration" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, desc = "LSP: Go to implementation" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, desc = "LSP: Rename" })
    vim.keymap.set(
        "n",
        "<leader>of",
        vim.diagnostic.open_float,
        { noremap = true, desc = "DIAGNOSTIC: Open errors in floating window" }
    )
    vim.keymap.set(
        "n",
        "<leader>gt",
        vim.diagnostic.goto_next,
        { noremap = true, desc = "DIAGNOSTIC: Go to next diagnostic" }
    )
    vim.keymap.set(
        "n",
        "<leader>gp",
        vim.diagnostic.goto_prev,
        { noremap = true, desc = "DIAGNOSTIC: Go to previous diagnostic" }
    )
    vim.keymap.set("n", "<leader>tp", vim.lsp.buf.typehierarchy, { noremap = true, desc = "LSP: Get type hierarchy" })

    vim.keymap.set("n", "<leader>ic", fzf.lsp_incoming_calls, { noremap = true, desc = "FZF: List incoming calls" })
    vim.keymap.set("n", "<leader>ot", fzf.lsp_outgoing_calls, { noremap = true, desc = "FZF: List outgoing call" })
    vim.keymap.set("n", "<leader>rf", fzf.lsp_references, { noremap = true, desc = "FZF: List references" })
    vim.keymap.set("n", "<leader>td", fzf.lsp_typedefs, { noremap = true, desc = "FZF: List type definitons" })
    vim.keymap.set("n", "<leader>ds", fzf.lsp_document_symbols, { noremap = true, desc = "FZF: List document symbols" })
    vim.keymap.set(
        { "n", "v" },
        "<leader>ca",
        fzf.lsp_code_actions,
        { noremap = true, desc = "FZF: List code actions" }
    )
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
            .. "/java_lsp_utilities/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.0.jar",
        1
    ),
}
vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(
            home_dir
                .. "/java_lsp_utilities/vscode-java-test/server/org.eclipse.jdt.junit5.runtime_1.1.300.v20231214-1952.jar",
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

        "/usr/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx4g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        home_dir
            .. "/java_lsp_utilities/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
        "-configuration",
        home_dir .. "/java_lsp_utilities/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux",
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
