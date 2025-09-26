return { "MeanderingProgrammer/render-markdown.nvim",
	config = function ()
		require("render-markdown").setup({
			completions = { lsp = { enabled = true } },
			code = {
				-- Determines how code blocks & inline code are rendered.
				-- | none     | disables all rendering                                                    |
				-- | normal   | highlight group to code blocks & inline code, adds padding to code blocks |
				-- | language | language icon to sign column if enabled and icon + name above code blocks |
				-- | full     | normal + language                                                         |
				style = "full",
				-- Whether to include the language icon above code blocks.
				language_icon = false,
				-- Whether to include the language name above code blocks.
				language_name = true,
			}
		})
	end
}

