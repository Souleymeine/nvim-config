return { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x",
    dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim"
	},
	config = function()
		vim.keymap.set('n', '<leader>e', ':Neotree filesystem toggle right<CR>')
		require("neo-tree").setup({
			source_selector = {
				winbar = true,
			},
			window = {
				mappings = {
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
				}
			},
			filesystem = {
				group_empty_dirs = true
			}
		})
	end
}
