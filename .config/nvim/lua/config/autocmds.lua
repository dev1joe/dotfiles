-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Kitty padding management
local function kitty_padding(value)
	vim.system({ "kitty", "@", "set-spacing", "padding=" .. value }):wait()
end

-- run immediately (works with or without file args)
kitty_padding(0)

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		kitty_padding(10)
	end,
})

vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true })
