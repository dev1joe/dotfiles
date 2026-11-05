-- lua/plugins/snacks.lua
return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			sources = {
				files = {
					exclude = { "node_modules", ".next" },
					hidden = true, -- Show hidden/dotfiles
					ignored = false, -- Respect .gitignore (set to true to show gitignored files too)
				},
				grep = {
					exclude = { "node_modules", ".next", "package-lock.json" },
					hidden = true, -- Search in hidden files
					ignored = false,
				},
				explorer = {
					hidden = true,
					ignored = true,
				},
			},
		},
	},
}
