vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Configure tabs
vim.cmd("set noexpandtab")
vim.cmd("set shiftwidth=4")
vim.cmd("set tabstop=4")
-- Show line numbers on the left
vim.cmd("set number")
vim.cmd("set numberwidth=2")
-- Show error, warning or breakpoint in line number column if there is one
vim.cmd("set signcolumn=number")

-- From https://jeffkreeftmeijer.com/vim-number/
-- For the syntax, try `:h vim.cmd`
vim.cmd([[
	augroup numbertoggle
		autocmd!
		autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu   | endif
		autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
	augroup END
]])

vim.diagnostic.config({
	update_in_insert = false,
	virtual_text = true
})

