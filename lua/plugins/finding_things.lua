return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            local utils = require("telescope.utils")

            vim.keymap.set("n", "<C-p>a", builtin.find_files, {})
            vim.keymap.set("n", "<C-p>r", function()
                builtin.find_files({ cwd = utils.buffer_dir() })
            end, {})

            vim.keymap.set("n", "<leader>fg", function()
                builtin.live_grep({
                    cwd = vim.fn.input("Path to basedir: ", vim.fn.getcwd() .. "/", "file"),
                    additional_args = {
                        "-u",
                        "--follow",
                        "--hidden",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--glob=!**/.git/*",
                        "--glob=!**/build/*",
                        "--glob=!**/.idea/*",
                    },
                })
            end, {})

            vim.keymap.set("n", "<C-p>c", builtin.current_buffer_fuzzy_find, {})
            vim.keymap.set("n", ";gc", builtin.git_commits, {})
            vim.keymap.set("n", ";gb", builtin.git_branches, {})
            vim.keymap.set("n", ";gs", builtin.git_status, {})
            vim.keymap.set("n", ";gst", builtin.git_stash, {})
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = {
                        "build",
                    },
                },
                pickers = {
                    find_files = {
                        find_command = {
                            "fdfind",
                            "--follow",
                            "--no-ignore-vcs",
                        },
                    },
                },
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
}
