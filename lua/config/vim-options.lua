vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Configure tabs
vim.cmd("set noexpandtab")
vim.cmd("set shiftwidth=4")
vim.cmd("set tabstop=4")
-- Show line numbers on the left
vim.cmd("set number")
vim.cmd("set numberwidth=2")
vim.cmd("set cursorline")
-- Show error, warning or breakpoint in line number column if there is one
vim.cmd("set signcolumn=number")
-- Scroll
vim.cmd("set scrolloff=2")

vim.api.nvim_create_user_command('FmtOnSave',
	function()
		-- For the syntax, try `:h vim.cmd`
		vim.cmd([[
			augroup fmtonsave
				autocmd!
				autocmd BufWritePost * silent lua vim.lsp.buf.format()
			augroup END
		]])
	end,
	{ nargs='?' }
)

-- Enable / Disable Relative line numbering in insert mode, as well as hilights for the current line
vim.api.nvim_create_user_command('CurrLineFocusOn', function() vim.cmd("set rnu | set culopt=both") end, { nargs='?' })
vim.api.nvim_create_user_command('CurrLineFocusOff', function() vim.cmd("set rnu! | set culopt=number") end, { nargs='?' })
-- From https://jeffkreeftmeijer.com/vim-number/
vim.cmd([[
	augroup numbertoggle
		autocmd!
		autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | CurrLineFocusOn | endif
		autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | CurrLineFocusOff | endif
	augroup END
]])

vim.diagnostic.config({
	update_in_insert = false,
	virtual_text = true
})

