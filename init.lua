vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.diagnostic.config({
	update_in_insert = false,
	virtual_text = true
})
vim.o.swapfile = false
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.number = true
vim.o.numberwidth = 2
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.signcolumn = "number"
vim.o.completeopt = "menuone,noselect,popup"
vim.o.complete = "o"
vim.o.autocomplete = false
vim.o.pumheight = 8
vim.o.pummaxwidth = 60
vim.o.termguicolors = true
-- TODO : send issue on GH
vim.o.pumborder = "single"
vim.o.winborder = "rounded"
-- From https://jeffkreeftmeijer.com/vim-number/
-- autocmd to set relative number if not in insert mode
vim.cmd([[
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu  | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set rnu! | endif
augroup END
]])
-- No mouse buttons when using vim, duh!
-- #larp
vim.cmd("set mouse=")

-- Plugins --
local function gh(path) return "https://github.com/" .. path end
local function cb(path) return "https://codeberg.org/" .. path end
vim.pack.add({
	gh("andweeb/presence.nvim"),

	gh("nvim-mini/mini.pick"),
	gh("stevearc/oil.nvim"),

	gh("mcauley-penney/visual-whitespace.nvim"),
	gh("lukas-reineke/indent-blankline.nvim"),

	gh("nvim-tree/nvim-web-devicons"),
	gh("dasupradyumna/midnight.nvim"),

	cb("mfussenegger/nvim-jdtls"),
	cb("ziglang/zig.vim"),

	gh("mfussenegger/nvim-dap"),
	gh("rcarriga/nvim-dap-ui"),
	gh("theHamsta/nvim-dap-virtual-text"),
	gh("nvim-neotest/nvim-nio"),
})

vim.cmd([[
colorscheme midnight
hi Normal guibg=Black
hi Pmenu guibg=Black
hi PmenuBorder guifg=#222222
]])
-- Use default theme bg color for VisualNonText bg
local theme_bg_hl = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
vim.api.nvim_set_hl(0, "VisualNonText", {
	fg = string.format("#%06X", theme_bg_hl + 0x111111),
	bg = string.format("#%06X", theme_bg_hl)
})

local istty = os.getenv("TERM") == "linux"
require("ibl").setup({
	indent = { char = (istty and { "│" } or { "▏" })[1] },
	scope = {
		enabled = true,
		show_start = false,
		show_end = false,
		char = (istty and { "│" } or { "▎" })[1],
	}
})
require("oil").setup()
require("mini.pick").setup({ delay = { async = 1, busy = 1 } })
require("presence").setup({
	neovim_image_text = "Terminal Text Editor",
	main_image = "file",
	file_explorer_text = "",
	git_commit_text = ""
})
local dap, dapui = require("dap"), require("dapui")
dapui.setup()
local open_ui = function() dapui.open() end
dap.listeners.before.attach.dapui_config = open_ui
dap.listeners.before.launch.dapui_config = open_ui
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config = dapui.close
-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#configuration-example
dap.adapters.lldb = {
	type = 'executable',
	command = '/usr/bin/lldb-dap', -- must be absolute path
	name = 'lldb'
}
dap.configurations.c = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', './', 'file')
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
		console = "integratedTerminal",
		initCommands = { "process handle SIGWINCH -p true -n false -s false" }, -- SIGWINCH causes the debugger to stop
	},
	{
		name = "Launch with arguments",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', './', 'file')
		end,
		args = function()
			return require("dap.utils").splitstr(vim.fn.input('Arguments: '))
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
		console = "integratedTerminal",
		initCommands = { "process handle SIGWINCH -p true -n false -s false" },
	}
}
dap.configurations.zig = dap.configurations.c
dap.configurations.rust = dap.configurations.c
require("nvim-dap-virtual-text").setup({})

-- LSP configs --
local local_bin = os.getenv('HOME') .. "/.local/bin/"
vim.lsp.enable({ "lua_ls", "zls", "clangd", "rust-analyzer" })
vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	settings = {
		Lua = {
			workspace = { library = vim.api.nvim_get_runtime_file("", true) }
		}
	}
})
vim.lsp.config("zls", {
	cmd = { local_bin .. "zls" },
	filetypes = { "zig" },
	root_markers = { "build.zig" },
	settings = {
		zls = { enable_build_on_save = true }
	}
})
vim.lsp.config("rust-analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "Cargo.lock" },
})
vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "cpp" },
	root_markers = { "compile_flags.txt", "compile_commands.json" },
})
vim.lsp.inline_completion.enable()
vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 1

-- Keymaps --
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.keymap.set({ 'n', 'v' }, "<C-f>", ":Pick files<CR>")
vim.keymap.set({ 'n', 'v' }, "<leader>e", ":Oil<CR>")

vim.keymap.set({ 'n', 'v' }, "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set({ 'n', 'v' }, 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', "<leader>r", vim.lsp.buf.rename, {})
vim.keymap.set('n', "<leader>fm", vim.lsp.buf.format, {})

vim.keymap.set('n', '<F5>', dap.continue, {})
vim.keymap.set('n', '<F10>', dap.step_over, {})
vim.keymap.set('n', '<F11>', dap.step_into, {})
vim.keymap.set('n', '<F12>', dap.step_out, {})
vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, {})
