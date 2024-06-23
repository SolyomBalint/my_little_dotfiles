return{
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
		ensure_installed = {"java", "c", "cpp", "cmake", "dockerfile", "doxygen", "json", "lua", "python", "vim", "vimdoc", "query"},
		highlight = { enable = true },
		indent = { enable = true },
		})
	end
}
