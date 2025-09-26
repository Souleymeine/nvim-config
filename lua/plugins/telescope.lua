return {
	{ "nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function ()
			local telescope = require("telescope")
			telescope.setup {
				extensions = {
					["ui-select"] = { require("telescope.themes").get_dropdown({}) }
				}
			}
			telescope.load_extension("ui-select")
			telescope.load_extension("lazygit")
		end
	},
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x",
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			-- Enables for fuzzy finding files with telescope
			local builtin = require("telescope.builtin")
			vim.keymap.set('n', '<C-s>', builtin.find_files, {})
		end
	}
}
