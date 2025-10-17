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
                enable = false,
            },
        },
        dependencies = {
            "saghen/blink.cmp",
        },
    },
}
