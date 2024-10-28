return {
    "vim-test/vim-test",
    dependencies = {
        "preservim/vimux",
    },
    keys = {
        { "<C-t>n", desc = "VIMTEST: Load vim test and run nearest test" },
        { "<C-t>f", desc = "VIMTEST: Load vim test and run tests in file" },
        { "<C-t>s", desc = "VIMTEST: Load vim test and run suite" },
    },
    config = function()
        vim.keymap.set("n", "<C-t>n", ":TestNearest<CR>", { noremap = true, desc = "VIMTEST: Run nearest test" })
        vim.keymap.set("n", "<C-t>f", ":TestFile<CR>", { noremap = true, desc = "VIMTEST: Run tests in file" })
        vim.keymap.set("n", "<C-t>l", ":TestLast<CR>", { noremap = true, desc = "VIMTEST: Run last test" })
        vim.keymap.set("n", "<C-t>v", ":TestVisit<CR>", { noremap = true, desc = "VIMTEST: Run visit test??" })
        vim.keymap.set("n", "<C-t>s", ":TestSuite<CR>", { noremap = true, desc = "VIMTEST: Run suite" })

        vim.g["test#strategy"] = "vimux"
    end,
}
