return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        config = function()
            local diags = require("tiny-inline-diagnostic")
            diags.setup({
                options = {
                    show_source = {
                        enabled = true,
                        if_many = true,
                    },
                    multilines = true,
                    -- show_all_diags_on_cursorline = true,
                    -- multiple_diag_under_cursor = true,
                },
            })
            vim.api.nvim_create_user_command("ToggleTinyDiags", function()
                diags.toggle()
            end, {})
            vim.api.nvim_create_user_command("SwitchToBasicDiags", function()
                diags.disable()
                vim.diagnostic.config({ virtual_text = true })
            end, {})
            vim.api.nvim_create_user_command("SwitchToTinyDiags", function()
                diags.enable()
                vim.diagnostic.config({ virtual_text = false })
            end, {})
        end,
    },
}
