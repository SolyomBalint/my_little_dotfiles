return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua, -- lua formatting
				null_ls.builtins.formatting.black, -- python formatting
				null_ls.builtins.formatting.isort, -- python import formatting
				null_ls.builtins.formatting.clang_format.with({ filetypes = { "c", "cpp" } }),
				null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh" } }),
			},
		})
        -- This is also considered formatting. At least by me.
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			pattern = { "*" },
			callback = function(ev)
				local save_cursor = vim.fn.getpos(".")
				vim.cmd([[%s/\s\+$//e]])
				vim.fn.setpos(".", save_cursor)
			end,
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
