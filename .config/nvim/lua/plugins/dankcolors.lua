return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#0f1417',
				base01 = '#1c2024',
				base02 = '#313539',
				base03 = '#41484d',
				base04 = '#c1c7ce',
				base05 = '#dfe3e7',
				base06 = '#dfe3e7',
				base07 = '#2c3134',
				base08 = '#ffb4ab',
				base09 = '#cbc1e9',
				base0A = '#c1c7ce',
				base0B = '#91cef5',
				base0C = '#b6c9d8',
				base0D = '#91cef5',
				base0E = '#b6c9d8',
				base0F = '#ffb4ab',
			})

			local function set_hl_mutliple(groups, value)
				for _, v in pairs(groups) do vim.api.nvim_set_hl(0, v, value) end
			end

			vim.api.nvim_set_hl(0, 'Visual',
				{ bg = '#004c6b', fg = '#c5e7ff', bold = true })
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#41484d' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#91cef5', bold = true })

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"

			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()

				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)

					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("󰂖 Matugen: Colors reloaded!")
					end
				end))
			end
		end
	}
}
