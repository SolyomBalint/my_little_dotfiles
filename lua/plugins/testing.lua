return {
	"vim-test/vim-test",
	config = function()
		vim.keymap.set("n", "<C-t>n", ":TestNearest<CR>", { noremap = true })
		vim.keymap.set("n", "<C-t>f", ":TestFile<CR>", { noremap = true })
		vim.keymap.set("n", "<C-t>l", ":TestLast<CR>", { noremap = true })
		vim.keymap.set("n", "<C-t>v", ":TestVisit<CR>", { noremap = true })
		vim.keymap.set("n", "<C-t>s", ":TestSuite<CR>", { noremap = true })

		vim.g["test#strategy"] = "vimux"
	end,
}
