return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						-- Add files/dirs to hide, e.g., ".git"
					},
					never_show = {},
				},
			},
		})
		vim.keymap.set("n", "<leader>b", ":Neotree filesystem reveal left<CR>")
		vim.keymap.set("n", "<leader>B", ":Neotree close<CR>")
	end,
}
