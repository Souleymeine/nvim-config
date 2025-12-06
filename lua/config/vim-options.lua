vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.cmd("\
set noexpandtab   | \z
set shiftwidth=4  | \z
set tabstop=4     | \z

set number        | \z
set numberwidth=2 | \z
set cursorline    | \z
set cursorlineopt=number | \z

set signcolumn=number | \z

set scrolloff=2\
")

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

-- From https://jeffkreeftmeijer.com/vim-number/
vim.cmd([[
	augroup numbertoggle
		autocmd!
		autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu | endif
		autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set rnu! | endif
	augroup END
]])

vim.diagnostic.config({
	update_in_insert = false,
	virtual_text = true
})

