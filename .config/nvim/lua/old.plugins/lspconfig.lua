return {
	{
		-- nvim/lspconfig
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.lsp.enable("lua_ls", "ts_ls", "dockerls", "docker_compose_language_service")
			vim.lsp.config("ts_ls", {capabilities = capabilities})
			vim.lsp.config("lua_ls", {capabilities = capabilities})
			vim.lsp.config("dockerls", {capabilities = capabilities})
			vim.lsp.config("docker_compose_language_service", {capabilities = capabilities})

			-- local opts = { buffer = env.buf }
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {})
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
			vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})

			-- vim diagnostics
			vim.diagnostic.config({
				virtual_text = true,        -- Show diagnostics inline with text
				signs = true,                -- Show signs in the sign column
				underline = true,            -- Underline problematic lines
				severity_sort = true,        -- Sort diagnostics by severity
				float = { source = "always" }, -- Show diagnostics in floating windows
			})
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
				ensure_installed = {
					"lua_ls",
					"ts_ls", -- do I need prettier and eslint if I have that ?
					"dockerls",
					"docker_compose_language_service",
					"stylua",
					-- eslint_d (if needed)
					-- prettier (if needed)
				},
			})
		end
	},
}
