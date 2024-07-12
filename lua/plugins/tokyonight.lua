return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night",
			transparent = true,
			terminal_colors = true,
			on_colors = function(colors)
				colors.comment = "#409e74" -- test comment
			end,
		})
		vim.cmd.colorscheme("tokyonight-night")
	end,
}
