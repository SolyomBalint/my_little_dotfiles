return {
	{ "cohama/lexima.vim" },
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
		config = function()
			require("Comment").setup({})
		end,
	},
}
