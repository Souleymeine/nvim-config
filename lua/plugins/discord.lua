return { "andweeb/presence.nvim",
	config = function ()
		require("presence").setup({
			neovim_image_text = "Terminal Text Editor",
			main_image = "file",
			file_explorer_text = "",
			git_commit_text = ""
		})
	end
}

