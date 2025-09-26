return {
	{
		"mason-org/mason-lspconfig.nvim",
		-- ft = { "c", "s", "cpp", "rs", "sh", "py", "lua" },
		opts = {},
		event = "InsertEnter",
		dependencies = {
			"neovim/nvim-lspconfig",
			{
				event = "InsertEnter",
				"mason-org/mason.nvim",
				opts = {}
			}
		},
		config = function()
			require("mason-lspconfig").setup({
				-- ensure_installed = { "lua_ls", "clangd", "jdtls" },
				automatic_enable = true
			})
			-- Keymaps
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
			vim.keymap.set({ 'n', 'v' }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set('n', "<leader>r", vim.lsp.buf.rename)
			vim.keymap.set('n', "<leader>fo", vim.lsp.buf.format, {})
			-- Link with completion plugin
			require("cmp").setup({
				sources = {
					{ name = "nvim_lsp" }
				}
			})
		end
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" }
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				-- performance = {
				-- 	max_view_entries = 10,
				-- },
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end
				},
				mapping = cmp.mapping.preset.insert({
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<C-j>"] = cmp.mapping.scroll_docs(-4),
					["<C-k>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-Esc>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false })
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "render-markdown" },
				}),
			})

			-- Seems useless now? (+ causes trouble)
			--
			-- -- Set up lspconfig.
			-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
			-- local lspconfig = require("lspconfig")
			--
			-- -- Lua specific stuff
			-- -- Kind of ugly but works
			-- local lua_ls_settings = {
			-- 	Lua = {
			-- 		diagnostics = { globals = { "vim" } },
			-- 		workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			-- 		-- telemetry = { enable = false },
			-- 	}
			-- }
			--
			-- -- Setup each language server
			-- -- for _, lsp in ipairs(require("mason-lspconfig").get_installed_servers()) do
			-- -- 	local setup = { capabilities = capabilities }
			-- -- 	if lsp == "lua_ls" then setup.settings = lua_ls_settings end
			-- -- 	lspconfig[lsp].setup(setup)
			-- -- end
		end
	},
}
