local last_open_git_repo_path = nil

return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gitsigns = require("gitsigns")

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gitsigns.nav_hunk("next")
                        end
                    end)

                    map("n", "[c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gitsigns.nav_hunk("prev")
                        end
                    end)

                    -- Actions
                    -- map("n", "<leader>gs", gitsigns.stage_hunk)
                    -- map("n", "<leader>gr", gitsigns.reset_hunk)
                    -- map("v", "<leader>gs", function()
                    --     gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    -- end)
                    -- map("v", "<leader>gr", function()
                    --     gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    -- end)
                    -- map("n", "<leader>gS", gitsigns.stage_buffer)
                    -- map("n", "<leader>gu", gitsigns.undo_stage_hunk)
                    -- map("n", "<leader>gR", gitsigns.reset_buffer)
                    -- map("n", "<leader>gp", gitsigns.preview_hunk)
                    -- map("n", "<leader>gb", function()
                    --     gitsigns.blame_line({ full = true })
                    -- end)
                    map("n", "<leader>gb", gitsigns.toggle_current_line_blame)
                    map("n", "<leader>gd", gitsigns.diffthis)
                    map("n", "<leader>gD", function()
                        gitsigns.diffthis("~")
                    end)
                    map("n", "<leader>td", gitsigns.toggle_deleted)

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            })
        end,
    },
    {
        'sindrets/diffview.nvim',
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration
            "ibhagwan/fzf-lua",       -- optional
        },
        config = function ()
            local neogit = require("neogit")
            neogit.setup({})
            vim.keymap.set("n", ";goc", neogit.open, { silent = true, noremap = true }) -- git open current
            vim.keymap.set("n", ";gop", function ()
                local cwd = vim.fn.input("Path to gitrepo: ", vim.fn.getcwd() .. "/", "file")
                last_open_git_repo_path = cwd
                neogit.open({ cwd=cwd })
            end ,{ silent = true, noremap = true }) -- git open path
            vim.keymap.set("n", ";gol", function ()
                neogit.open({cwd=last_open_git_repo_path})
            end, { silent = true, noremap = true }) -- git open last
        end

    }
}
