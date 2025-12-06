local tty = os.getenv("TERM") == "linux"

return {
	{	"mcauley-penney/visual-whitespace.nvim",
		priority = -1,
		config = function()
			-- Use default theme bg color for VisualNonText bg
			local theme_bg_hl = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
			vim.api.nvim_set_hl(0, "VisualNonText", { fg = string.format("#%06X", theme_bg_hl + 0x111111), bg = string.format("#%06X", theme_bg_hl) })
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

