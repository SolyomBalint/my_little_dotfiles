return {

    { "echasnovski/mini.icons", lazy = true, version = false },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    ---@type LazySpec
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            {
                "-",
                "<cmd>Yazi<cr>",
                desc = "YAZI: Open yazi at the current file",
            },
            {
                "<C-y>cw",
                "<cmd>Yazi cwd<cr>",
                desc = "YAZI: Open the file manager in nvim's working directory",
            },
            {
                "<C-y>p",
                "<cmd>Yazi toggle<cr>",
                desc = "YAZI: Resume the last yazi session",
            },
        },
        ---@type YaziConfig
        opts = {
            open_for_directories = true,
            clipboard_register = "+",
            keymaps = {
                show_help = "<f1>",
            },
        },
    },
}
