local searchPlace = vim.fn.getcwd()

return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        keys = {
            { "<C-e>", desc = "HP: Load and open harpoon" },
            { ";1", desc = "HP: Load harpoon and switch to file 1" },
            { ";2", desc = "HP: Load harpoon and switch to file 2" },
            { ";3", desc = "HP: Load harpoon and switch to file 3" },
            { ";4", desc = "HP: Load harpoon and switch to file 4" },
            { "<leader>a", desc = "HP: Load harpoon add file to it" },
        },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()
            vim.keymap.set("n", "<C-e>", function()
                harpoon:list()
            end, { desc = "HP: Open harpoon window" })

            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
            end, { desc = "HP: Add current buffer to harpoon" })
            vim.keymap.set("n", "<C-e>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = "HP: Toggle harpoon menu" })

            vim.keymap.set("n", ";1", function()
                harpoon:list():select(1)
            end, { desc = "HP: Switch to harpoon file 1" })
            vim.keymap.set("n", ";2", function()
                harpoon:list():select(2)
            end, { desc = "HP: Switch to harpoon file 2" })
            vim.keymap.set("n", ";3", function()
                harpoon:list():select(3)
            end, { desc = "HP: Switch to harpoon file 3" })
            vim.keymap.set("n", ";4", function()
                harpoon:list():select(4)
            end, { desc = "HP: Switch to harpoon file 4" })

            vim.keymap.set("n", "<C-S-P>", function()
                harpoon:list():prev()
            end, { desc = "HP: Go to previous harpoon files" })
            vim.keymap.set("n", "<C-S-N>", function()
                harpoon:list():next()
            end, { desc = "HP: Go to next harpoon files" })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local fzf = require("fzf-lua")

            fzf.setup({})
            local rg_cmd = "rg -u --follow --hidden --with-filename --line-number --column --smart-case"
                .. " --glob=!**/.git/* --glob=!**/build/* --glob=!**/.idea/* --glob=!**/.cache/* --glob=!**/.devenv/* --glob=!**/.direnv/*"
            vim.keymap.set("n", "<C-p>a", function()
                Snacks.input({
                    prompt = "Path to basedir: ",
                    default = searchPlace .. (searchPlace:sub(-1) == "/" and "" or "/"),
                    completion = "file",
                }, function(input)
                    if input ~= nil then
                        searchPlace = input
                        fzf.files({
                            cwd = input,
                            cmd = "fd --follow --hidden --no-ignore-vcs -E !**/build/* -E build -E !**/.git/* -E .git -E !**/.devenv/* -E .devenv",
                        })
                    end
                end)
            end, { noremap = true, desc = "FZF: search for files in input dir" })
            vim.keymap.set("n", "<leader>lg", function()
                Snacks.input({
                    prompt = "Path to basedir: ",
                    default = searchPlace .. (searchPlace:sub(-1) == "/" and "" or "/"),
                    completion = "file",
                }, function(input)
                    if input ~= nil then
                        searchPlace = input
                        fzf.live_grep({
                            cwd = input,
                            cmd = rg_cmd,
                        })
                    end
                end)
            end, { noremap = true, desc = "FZF: Live grep in input dir wiht glob support" })
            vim.keymap.set("v", "<C-p>v", function()
                Snacks.input({
                    prompt = "Path to basedir: ",
                    default = searchPlace .. (searchPlace:sub(-1) == "/" and "" or "/"),
                    completion = "file",
                }, function(input)
                    if input ~= nil then
                        searchPlace = input
                        fzf.grep_visual({
                            cwd = input,
                            cmd = rg_cmd,
                        })
                    end
                end)
            end, { noremap = true, desc = "FZF: Grep for the highlighted word in input dir" })
            vim.keymap.set(
                "n",
                "<C-p>rl",
                fzf.live_grep_resume,
                { noremap = true, desc = "FZF: Resume last grep search" }
            )
            vim.keymap.set(
                "n",
                "<C-p>c",
                fzf.lgrep_curbuf,
                { noremap = true, desc = "FZF: Live grep in current buffer" }
            )
            vim.keymap.set("n", "<C-p>sh", fzf.search_history, { noremap = true, desc = "FZF: Vim search history" })
            vim.keymap.set(
                "n",
                "<C-p>cmd",
                fzf.command_history,
                { noremap = true, desc = "FZF: Vim command line history" }
            )
            vim.keymap.set("n", "<C-p>od", fzf.oldfiles, { noremap = true, desc = "FZF: List previously opened files" })
            vim.keymap.set(
                "n",
                "<leader>dl",
                fzf.dap_breakpoints,
                { noremap = true, desc = "FZF: List dap breakpoints" }
            )
            vim.keymap.set("n", "<C-p>b", fzf.buffers, { noremap = true, desc = "FZF: List open buffers" })
            vim.keymap.set("n", "<C-p>k", fzf.keymaps, { noremap = true, desc = "FZF: Search loaded keymaps" })
            -- TODO think this through
            vim.keymap.set("n", ";gc", fzf.git_commits, { desc = "FZF: Search git commits" })
            vim.keymap.set("n", ";gb", fzf.git_branches, { desc = "FZF: Search git branches" })
            vim.keymap.set("n", ";gs", fzf.git_status, { desc = "FZF: Check git status" })
            vim.keymap.set("n", ";gst", fzf.git_stash, { desc = "FZF: Search git stash" })
        end,
    },
}
