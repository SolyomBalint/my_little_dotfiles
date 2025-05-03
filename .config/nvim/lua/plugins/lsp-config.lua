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
    vim.keymap.set("n", "<leader>gt", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, { noremap = true, desc = "DIAGNOSTIC: Go to next diagnostic" })
    vim.keymap.set("n", "<leader>gp", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, { noremap = true, desc = "DIAGNOSTIC: Go to previous diagnostic" })
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
        -- LSP config plugin provides default inits for language servers while neovim does not, hence this plugin is
        -- still useful
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = { "onsails/lspkind.nvim" },
        config = function()
            local basic_lsp_list =
                { "clangd", "glsl_analyzer", "neocmake", "marksman", "pyright", "ts_ls", "nixd", "lua_ls" }

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

            -- This way the default on attach functions can do their thing in the plugin
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(args)
                    local buffer = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    on_attach()
                end,
            })

            -- Default settings for every lsp
            vim.lsp.config("*", {
                capabilities = {
                    textDocument = {
                        semanticTokens = {
                            multilineTokenSupport = true,
                        },
                    },
                },
                root_markers = { ".git" },
                on_attach = on_attach,
            })

            vim.lsp.config("clangd", {
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
                root_markers = {
                    ".clangd",
                    ".clang-tidy",
                    ".clang-format",
                    "compile_commands.json",
                    "build/compile_commands.json",
                    "compile_flags.txt",
                    "configure.ac", -- AutoTools
                    ".git",
                },
            })

            -- Setting up lsp-s with basic setup
            for _, lsp in ipairs(basic_lsp_list) do
                vim.lsp.enable(lsp)
            end
        end,
    },
}
