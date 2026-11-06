return {
	-- 1. Mason (Package Manager for LSPs, Formatters, Linters)
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				-- LSPs
				"docker-compose-language-service",
				"dockerfile-language-server",
				"intelephense",
				"json-lsp",
				"lua-language-server",
				"omnisharp",
				"prisma-language-server",
				"pyright",
				"typescript-language-server",
				"yaml-language-server",

				-- Linters
				"hadolint",
				"kube-linter",

				-- Formatters
				"stylua",
				"shfmt",
			},
		},
	},

	-- 2. Mason-LSPConfig (Bridge between Mason and lspconfig)
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"dockerls", -- dockerfile-language-server
				"docker_compose_language_service", -- docker-compose-language-service
				"intelephense",
				"jsonls", -- json-lsp
				"lua_ls", -- lua-language-server
				"omnisharp",
				"prismals", -- prisma-language-server
				"pyright",
				"ts_ls", -- typescript-language-server
				"yamlls", -- yaml-language-server
			},
		},
	},
}
