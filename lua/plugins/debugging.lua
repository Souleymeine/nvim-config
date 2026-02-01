return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dap.defaults.fallback.external_terminal = {
			command = '/usr/bin/kitty',
			args = { '-e' },
		}
		-- Keymaps
		vim.keymap.set('n', '<F5>', dap.continue, {})
		vim.keymap.set('n', '<F10>', dap.step_over, {})
		vim.keymap.set('n', '<F11>', dap.step_into, {})
		vim.keymap.set('n', '<F12>', dap.step_out, {})
		vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, {})

		dapui.setup()

		-- dapui actions
		local open_ui = function()
			dapui.open()
		end

		dap.listeners.before.attach.dapui_config = open_ui
		dap.listeners.before.launch.dapui_config = open_ui
		dap.listeners.before.event_terminated.dapui_config = dapui.close
		dap.listeners.before.event_exited.dapui_config = dapui.close

		-- Debugger configuration
		-- From https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-lldb-vscode
		dap.adapters.lldb = {
			type = "executable",
			command = "/usr/bin/lldb-dap",
			name = "lldb"
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
			},
			{
				name = "Launch with arguments",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input('Path to executable: ', './', 'file')
				end,
				args = function()
					return vim.fn.input('Arguments: ')
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			}
		}

		dap.configurations.zig = dap.configurations.c

		require("nvim-dap-virtual-text").setup()
	end
}
