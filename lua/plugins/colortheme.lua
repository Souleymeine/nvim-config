return {
	"EdenEast/nightfox.nvim",
	config = function()
		-- The theme must be set while the plugin is loaded
		-- For first installs or reinstalls, to avoid errors.
		vim.cmd("colorscheme carbonfox")
	end
}

