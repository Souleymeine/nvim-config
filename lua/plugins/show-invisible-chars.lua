local tty = os.getenv("TERM") == "linux"

return {
	{	"mcauley-penney/visual-whitespace.nvim",
		priority = -1,
		config = function()
			-- Make the background characters match the current color theme
			-- I have no idea how I came up with this, but I did...
			local default_highlight = string.format("#%X", vim.api.nvim_get_hl(0, { name = "Visual" }).bg)
			vim.api.nvim_set_hl(0, "VisualNonText", { fg = "#555555", bg = default_highlight})
			vim.api.nvim_set_hl(0, "Constant", { fg = "#CC66EE", bg = ""})
		end
	},
	{	"lukas-reineke/indent-blankline.nvim",
		main = "ibl", opts = {},
		config = function()
			require("ibl").setup({
				indent = { char = (tty and {'│'} or {'▏'})[1] },
				scope = {
					enabled = true,
					show_start = false,
					show_end = false,
					char = (tty and {'│'} or {'▎'})[1],
				}
			})
		end
	}
}

