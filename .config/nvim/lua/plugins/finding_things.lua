return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()
            vim.keymap.set("n", "<C-e>", function()
                harpoon:list()
            end, { desc = "Open harpoon window" })

            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
            end)
            vim.keymap.set("n", "<C-e>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            vim.keymap.set("n", ";1", function()
                harpoon:list():select(1)
            end)
            vim.keymap.set("n", ";2", function()
                harpoon:list():select(2)
            end)
            vim.keymap.set("n", ";3", function()
                harpoon:list():select(3)
            end)
            vim.keymap.set("n", ";4", function()
                harpoon:list():select(4)
            end)

            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end)
            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end)
        end,
    },
    { "junegunn/fzf", build = "./install --bin" },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local fzf = require("fzf-lua")

            fzf.setup({})
            local rg_cmd = "rg -u --follow --hidden --with-filename --line-number --column --smart-case"
                .. " --glob=!**/.git/* --glob=!**/build/* --glob=!**/.idea/*"
            vim.keymap.set("n", "<C-p>a", function()
                fzf.files({
                    cwd = vim.fn.input("Path to basedir: ", vim.fn.getcwd() .. "/", "file"),
                    cmd = "fd --follow --hidden --no-ignore-vcs -E !**/build/* -E build"
                })
            end, { noremap = true })
            vim.keymap.set("n", "<leader>lg", function()
                fzf.live_grep_glob({
                    cwd = vim.fn.input("Path to basedir: ", vim.fn.getcwd() .. "/", "file"),
                    cmd = rg_cmd,
                })
            end, { noremap = true })
            vim.keymap.set("v", "<C-p>v", function()
                fzf.grep_visual({
                    cwd = vim.fn.input("Path to basedir: ", vim.fn.getcwd() .. "/", "file"),
                    cmd = rg_cmd,
                })
            end, { noremap = true })
            vim.keymap.set("n", "<C-p>rl", fzf.live_grep_resume, { noremap = true })
            vim.keymap.set("n", "<C-p>c", fzf.lgrep_curbuf, { noremap = true })
            vim.keymap.set("n", "<C-p>sh", fzf.search_history, { noremap = true })
            vim.keymap.set("n", "<C-p>cmd", fzf.command_history, { noremap = true })
            vim.keymap.set("n", "<C-p>od", fzf.oldfiles, { noremap = true })
            vim.keymap.set("n", "<leader>dlb", fzf.dap_breakpoints, { noremap = true })
            -- TODO think this through
            vim.keymap.set("n", ";gc", fzf.git_commits, {})
            vim.keymap.set("n", ";gb", fzf.git_branches, {})
            vim.keymap.set("n", ";gs", fzf.git_status, {})
            vim.keymap.set("n", ";gst", fzf.git_stash, {})
        end,
    },
}
