return {
	{
		-- nvim/lspconfig
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			vim.lsp.enable("lua_ls", "ts_ls", "dockerls", "docker_compose_language_service")
			-- "dockerls", "docker_compose_language_service"

			-- local opts = { buffer = env.buf }
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {})
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
			vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
		end
	},
	{
		-- mason
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})
		end
	},
	{
		-- mason-lspconfig
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "dockerls", "docker_compose_language_service" },
			})
		end
	},
}
