return {
    {
        "danymat/neogen",
        config = function()
            local neogen = require("neogen")
            neogen.setup({
                enabled = true,
                input_after_comment = true,
                snippet_engine = "luasnip",
                languages = {
                    python = {
                        template = {
                            annotation_convention = "google_docstrings"
                        }
                    }
                }
            })

            vim.keymap.set("n", ";df", function() neogen.generate({ type = 'func' }) end,
                { noremap = true, silent = true })
            vim.keymap.set("n", ";dc", function() neogen.generate({ type = 'class' }) end,
                { noremap = true, silent = true })
            vim.keymap.set("n", ";dt", function() neogen.generate({ type = 'type' }) end,
                { noremap = true, silent = true })
            vim.keymap.set("n", ";dfl", function() neogen.generate({ type = 'file' }) end,
                { noremap = true, silent = true })
        end
    }
}
