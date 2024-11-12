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
end

return {
    {
        "ray-x/lsp_signature.nvim",
        opts = {
            bind = true,
            handler_opts = {
                border = "rounded",
            },
            hint_inline = function()
                return "inline"
            end,
            floating_window = false,
            hint_prefix = " ",
        },
        config = function(_, opts)
            require("lsp_signature").setup(opts)
            vim.keymap.set({ "n" }, "<C-k>", function()
                require("lsp_signature").toggle_float_win()
            end, { silent = true, noremap = true, desc = "SIG: toggle signature" })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if vim.tbl_contains({ "null-ls" }, client.name) then -- blacklist lsp
                        return
                    end
                    require("lsp_signature").on_attach({}, bufnr)
                end,
            })
        end,
    },
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
