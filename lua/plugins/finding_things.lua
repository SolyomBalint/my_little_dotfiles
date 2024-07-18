return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-p>", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<M-g>c", builtin.git_commits, {})
            vim.keymap.set("n", "<M-g>b", builtin.git_branches, {})
            vim.keymap.set("n", "<M-g>s", builtin.git_status, {})
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim", "telescope.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers")
                    .new({}, {
                        prompt_title = "Harpoon",
                        finder = require("telescope.finders").new_table({
                            results = file_paths,
                        }),
                        previewer = conf.file_previewer({}),
                        sorter = conf.generic_sorter({}),
                    })
                    :find()
            end

            vim.keymap.set("n", "<C-e>", function()
                toggle_telescope(harpoon:list())
            end, { desc = "Open harpoon window" })

            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
            end)
            vim.keymap.set("n", "<C-e>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            vim.keymap.set("n", "<C-h>", function()
                harpoon:list():select(1)
            end)
            vim.keymap.set("n", "<C-t>", function()
                harpoon:list():select(2)
            end)
            vim.keymap.set("n", "<C-n>", function()
                harpoon:list():select(3)
            end)
            vim.keymap.set("n", "<C-s>", function()
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
}