return {
	{
		-- completion source for nvim-cmp, sources neovim's built-in language server client
		-- supposedly, it provides completinos from language servers in buffer to nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		-- snippet engine/provider for neovim written in lua
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip", -- the completion source for luasnip
			"rafamadriz/friendly-snippets", -- collection of vscode like snippets source
		},
	},
	{
		-- A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			local border = {
				{ "╭", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╮", "CmpBorder" },
				{ "│", "CmpBorder" },
				{ "╯", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╰", "CmpBorder" },
				{ "│", "CmpBorder" },
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						border = border,
						winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
					},
					documentation = {
						border = border,
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
