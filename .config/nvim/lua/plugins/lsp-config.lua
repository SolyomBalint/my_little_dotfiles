local fzf = require("fzf-lua")

local on_attach = function(bufnr)
    vim.keymap.set(
        "n",
        "I",
        vim.lsp.buf.hover,
        { buf = bufnr, noremap = true, desc = "LSP: Hover" }
    )
    vim.keymap.set(
        "n",
        "gd",
        vim.lsp.buf.definition,
        { buf = bufnr, noremap = true, desc = "LSP: Go to definition" }
    )
    vim.keymap.set(
        "n",
        "<leader>wa",
        vim.lsp.buf.add_workspace_folder,
        { buf = bufnr, noremap = true, desc = "LSP: Add workspace folder" }
    )
    vim.keymap.set(
        "n",
        "gD",
        vim.lsp.buf.declaration,
        { buf = bufnr, noremap = true, desc = "LSP: Go to declaration" }
    )
    vim.keymap.set(
        "n",
        "gi",
        vim.lsp.buf.implementation,
        { buf = bufnr, noremap = true, desc = "LSP: Go to implementation" }
    )
    vim.keymap.set(
        "n",
        "<leader>rn",
        vim.lsp.buf.rename,
        { buf = bufnr, noremap = true, desc = "LSP: Rename" }
    )
    vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, {
        buf = bufnr,
        noremap = true,
        desc = "DIAGNOSTIC: Open errors in floating window",
    })
    vim.keymap.set("n", "<leader>gt", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, {
        buf = bufnr,
        noremap = true,
        desc = "DIAGNOSTIC: Go to next diagnostic",
    })
    vim.keymap.set("n", "<leader>gp", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, {
        buf = bufnr,
        noremap = true,
        desc = "DIAGNOSTIC: Go to previous diagnostic",
    })
    vim.keymap.set(
        "n",
        "<leader>tp",
        vim.lsp.buf.typehierarchy,
        { buf = bufnr, noremap = true, desc = "LSP: Get type hierarchy" }
    )

    vim.keymap.set(
        "n",
        "<leader>ic",
        fzf.lsp_incoming_calls,
        { buf = bufnr, noremap = true, desc = "FZF: List incoming calls" }
    )
    vim.keymap.set(
        "n",
        "<leader>ot",
        fzf.lsp_outgoing_calls,
        { buf = bufnr, noremap = true, desc = "FZF: List outgoing call" }
    )
    vim.keymap.set(
        "n",
        "<leader>rf",
        fzf.lsp_references,
        { buf = bufnr, noremap = true, desc = "FZF: List references" }
    )
    vim.keymap.set(
        "n",
        "<leader>td",
        fzf.lsp_typedefs,
        { buf = bufnr, noremap = true, desc = "FZF: List type definitons" }
    )
    vim.keymap.set(
        "n",
        "<leader>ds",
        fzf.lsp_document_symbols,
        { buf = bufnr, noremap = true, desc = "FZF: List document symbols" }
    )
    vim.keymap.set(
        { "n", "v" },
        "<leader>ca",
        fzf.lsp_code_actions,
        { buf = bufnr, noremap = true, desc = "FZF: List code actions" }
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
            local basic_lsp_list = {
                "clangd",
                "glsl_analyzer",
                "neocmake",
                "marksman",
                "pyright",
                "ts_ls",
                "nixd",
                "lua_ls",
                "tinymist",
                "cypher_ls",
                "rust_analyzer",
            }

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

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(args)
                    on_attach(args.buf)
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
            })

            local clangd_cmd = vim.env.CLANGD_CMD or "clangd"

            vim.lsp.config("clangd", {
                cmd = {
                    clangd_cmd,
                    "-j=4",
                    "--clang-tidy",
                    "--pretty",
                    "--background-index",
                    "--pch-storage=memory",
                    "--all-scopes-completion",
                    "--header-insertion=never",
                    "--completion-style=detailed",
                    "--query-driver=/nix/store/*/bin/gcc,/nix/store/*/bin/g++,/nix/store/*/bin/clang,/nix/store/*/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
                    "--header-insertion-decorators",
                },
                filetypes = { "c", "cpp", "cuda" },
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

            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        diagnostics = {
                            enable = true,
                        },
                        checkOnSave = true,
                    },
                },
            })

            vim.lsp.config("tinymist", {
                settings = {
                    formatterMode = "typstyle",
                    exportPdf = "onType",
                    semanticTokens = "disable",
                },
            })

            -- Setting up lsp-s with basic setup
            for _, lsp in ipairs(basic_lsp_list) do
                vim.lsp.enable(lsp)
            end
        end,
    },
}
