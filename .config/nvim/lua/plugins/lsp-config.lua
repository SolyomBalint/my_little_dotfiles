local fzf = require("fzf-lua")

local on_attach = function()
    vim.keymap.set("n", "I", vim.lsp.buf.hover, { noremap = true })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { noremap = true })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true })
    vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, { noremap = true })
    vim.keymap.set("n", "<leader>gt", vim.diagnostic.goto_next, { noremap = true })
    vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, { noremap = true })
    vim.keymap.set("n", "<leader>tp", vim.lsp.buf.typehierarchy, { noremap = true })

    vim.keymap.set("n", "<leader>ic", fzf.lsp_incoming_calls, { noremap = true })
    vim.keymap.set("n", "<leader>ot", fzf.lsp_outgoing_calls, { noremap = true })
    vim.keymap.set("n", "<leader>rf", fzf.lsp_references, { noremap = true })
    vim.keymap.set("n", "<leader>td", fzf.lsp_typedefs, { noremap = true })
    vim.keymap.set("n", "<leader>ds", fzf.lsp_document_symbols, { noremap = true })
    vim.keymap.set({ "n", "v" }, "<leader>ca", fzf.lsp_code_actions, { noremap = true })
end

return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            require("mason-lspconfig").setup({
                auto_install = true,
                ensure_installed = { "clangd", "lua_ls", "cmake", "bashls", "marksman", "pyright" },
            })
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,
                ["clangd"] = function()
                    require("lspconfig").clangd.setup({
                        cmd = {
                            "clangd",
                            "-j=4",
                            "--offset-encoding=utf-16",
                            "--clang-tidy",
                            "--pretty",
                            "--inlay-hints",
                            "--background-index",
                            "--pch-storage=memory",
                            "--all-scopes-completion",
                            "--header-insertion=never",
                            "--function-arg-placeholders",
                            "--completion-style=detailed",
                            "--header-insertion-decorators",
                        },
                        filetypes = { "c", "cpp" },
                        root_dir = require("lspconfig").util.root_pattern("src"),
                        capabilities = capabilities,
                        on_attach = function()
                            -- require("clangd_extensions.inlay_hints").setup_autocmd()
                            -- require("clangd_extensions.inlay_hints").set_inlay_hints()
                            on_attach()
                        end,
                    })
                end,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
    },
}
