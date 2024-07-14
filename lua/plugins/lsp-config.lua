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
        opts = {
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function() -- To avoid later key conflicts use auto_cmd
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.jdtls.setup({
                capabilities = capabilities,
            })
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    vim.keymap.set("n", "I", vim.lsp.buf.hover, { noremap = true })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { noremap = true })
                    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { noremap = true })
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true })
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true })
                    vim.keymap.set("n", "rn", vim.lsp.buf.rename, { noremap = true })

                    vim.keymap.set("n", "<leader>ic", ":Telescope lsp_incoming_calls<CR>", { noremap = true })
                    vim.keymap.set("n", "<leader>ot", ":Telescope lsp_outgoing_calls<CR>", { noremap = true })
                    vim.keymap.set("n", "<leader>rf", ":Telescope lsp_references<CR>", { noremap = true })
                    vim.keymap.set("n", "<leader>td", ":Telescope lsp_type_definitions<CR>", { noremap = true })
                    vim.keymap.set("n", "<leader>ds", ":Telescope lsp_document_symbols<CR>", { noremap = true })
                    if client.supports_method("textDocument/typehierarchy") then
                        vim.keymap.set("n", "<leader>tp", vim.lsp.buf.typehierarchy, { noremap = true })
                    end
                end,
            })
        end,
    },
}
