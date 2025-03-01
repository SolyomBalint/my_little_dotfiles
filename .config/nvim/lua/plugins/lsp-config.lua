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
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = { "onsails/lspkind.nvim", "saghen/blink.cmp" },
        config = function()
            local basic_lsp_list = { "glsl_analyzer", "neocmake", "marksman", "pyright", "ts_ls" }
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- setup() is also available as an alias
            require("lspkind").init({
                mode = "symbol_text",

                preset = "codicons",

                symbol_map = {
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰊕",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈙",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                },
            })
            local lspconfig = require("lspconfig")
            -- Setting up lsp-s with basic setup
            for _, lsp in ipairs(basic_lsp_list) do
                lspconfig[lsp].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end

            lspconfig.nixd.setup({
                cmd = { "nixd" },
                settings = {
                    nixd = {
                        nixpkgs = {
                            expr = "import <nixpkgs> {  }",
                        },
                    },
                },
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig.clangd.setup({
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

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "lua" },
                settings = {
                    Lua = {
                        workspace = {
                            library = {
                                -- This temporary only for my local development, a not so hardcoded solutions would be
                                -- nice
                                vim.fn.expand("~/personal/projects/sources_for_lsps/astal/lang/lua/"),
                            },
                        },
                    },
                },
            })
        end,
    },
}
