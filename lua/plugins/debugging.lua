return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
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
			vim.cmd("Neotree close")
		end

		dap.listeners.before.attach.dapui_config = open_ui
		dap.listeners.before.launch.dapui_config = open_ui
		dap.listeners.before.event_terminated.dapui_config = dapui.close
		dap.listeners.before.event_exited.dapui_config = dapui.close

		-- Debugger configuration
		-- From https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-gdb
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
		}
		dap.configurations.c = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input('Path to executable: ', './', 'file')
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Launch with arguments",
				type = "gdb",
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

		dap.adapters.bashdb = {
			type = 'executable',
			command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
			name = 'bashdb',
		}

		dap.configurations.sh = {
			{
				type = 'bashdb',
				request = 'launch',
				name = "Launch file",
				showDebugOutput = true,
				pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
				pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
				trace = true,
				file = "${file}",
				program = "${file}",
				cwd = '${workspaceFolder}',
				pathCat = "cat",
				pathBash = "/bin/bash",
				pathMkfifo = "mkfifo",
				pathPkill = "pkill",
				args = {},
				argsString = '',
				env = {},
				terminalKind = "integrated",
			}
		}
		dap.adapters.java = function(callback)
			callback({
				type = 'server',
				host = '127.0.0.1',
				port = port,
			})
		end
		dap.configurations.java = {
			{
				request = "launch",
				type = "java"
			}
		}
	end
}
