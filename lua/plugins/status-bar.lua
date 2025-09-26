return { 'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup({
			options = {
				globalstatus = true,
				section_separators = { left = '', right = '' },
				component_separators = { left = '', right = '' },
				refresh = {
					refresh_time = 96,
				}
			}
		})
	end
}
