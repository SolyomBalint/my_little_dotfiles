return {
    {
        "chomosuke/typst-preview.nvim",
        lazy = false,
        version = "1.*",
        opts = {
            dependencies_bin = {
                ["tinymist"] = vim.fn.expand("~/.nix-profile/bin/tinymist"),
            },
        },
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        priority = 49,
        opts = {
            preview = {
                filetypes = { "markdown", "codecompanion" },
                ignore_buftypes = {},
            },
        },
        dependencies = {
            "saghen/blink.cmp",
        },
    },
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- zathura_simple does not need xdotool, so it works on Wayland
            vim.g.vimtex_view_method = "zathura_simple"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = "build",
                out_dir = "build",
                options = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-file-line-error" },
            }
            vim.g.vimtex_quickfix_open_on_warning = 0

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "tex",
                callback = function()
                    vim.opt_local.conceallevel = 2
                end,
            })
        end,
    },
}
