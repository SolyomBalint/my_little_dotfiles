return {
    {
        "danymat/neogen",
        keys = {
            {
                ";df",
                function()
                    require("neogen").generate({ type = "func" })
                end,
                desc = "NEOGEN: Load neogen and generate function docs",
            },
            {
                ";dc",

                function()
                    require("neogen").generate({ type = "class" })
                end,
                desc = "NEOGEN: Load neogen and generate class docs",
            },
            {
                ";dt",
                function()
                    require("neogen").generate({ type = "type" })
                end,
                desc = "NEOGEN: Load neogen and generate type docs",
            },
            {
                ";dfl",
                function()
                    require("neogen").generate({ type = "file" })
                end,
                desc = "NEOGEN: Load neogen and generate file docs",
            },
        },
        config = function()
            local neogen = require("neogen")
            neogen.setup({
                enabled = true,
                input_after_comment = true,
                snippet_engine = "luasnip",
                languages = {
                    python = {
                        template = {
                            annotation_convention = "google_docstrings",
                        },
                    },
                },
            })

            vim.keymap.set("n", ";df", function()
                neogen.generate({ type = "func" })
            end, { noremap = true, silent = true, desc = "NEOGEN: Generate function docs" })
            vim.keymap.set("n", ";dc", function()
                neogen.generate({ type = "class" })
            end, { noremap = true, silent = true, desc = "NEOGEN: Generate class docs" })
            vim.keymap.set("n", ";dt", function()
                neogen.generate({ type = "type" })
            end, { noremap = true, silent = true, desc = "NEOGEN: Generate type docs" })
            vim.keymap.set("n", ";dfl", function()
                neogen.generate({ type = "file" })
            end, { noremap = true, silent = true, desc = "NEOGEN: Generate file docs" })
        end,
    },
}
