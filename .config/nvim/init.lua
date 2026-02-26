-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- IMPORTANT: clipboard
vim.opt.clipboard = "unnamedplus"

-- text lines
vim.opt.wrap = false

-- tab behavior and indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- background transparency
-- vim.cmd [[
--    highlight Normal guibg=none
--    highlight NonText guibg=none
--    highlight Normal ctermbg=none
--    highlight NonText ctermbg=none
--  ]]   

-- kitty transparency handling, TODO: it's not working!
vim.api.nvim_create_autocmd("VimEnter", {
  command = ":silent !kitty @ set-spacing padding=0",
})
vim.api.nvim_create_autocmd("VimLeave", {
  command = ":silent !kitty @ set-spacing padding=default",
})   

-- assign leader 
vim.g.mapleader = " "

-- load lazy package manager
require("config.lazy")
