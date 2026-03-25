return {
	{
		"mason-org/mason-lspconfig.nvim",
		-- ft = { "c", "s", "zig", "js", "ts", "cpp", "rs", "sh", "py", "lua" },
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
	{ "ziglang/zig.vim", ft="zig" },
	{ "rust-lang/rust.vim", ft="rust",
		config = function ()
			vim.g.rustfmt_autosave = 1
		end
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
				window = {
					completion = {
						max_height = 5,
					},
				},
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
		end
	},
}
