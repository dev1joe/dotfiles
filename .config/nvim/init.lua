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
vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]   
