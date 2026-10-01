-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- <cmd> tells neovim to execute a vim Ex command, it's like hitting : (colon) on your keyboard
-- <CR> stands for "Carriage Return"
vim.keymap.set("n", "U", "<cmd>redo<CR>", { desc = "Redo" })

-- move line up and down using alt and arrow keys like vscode
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { silent = true })
-- vim.keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { silent = true })
-- vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { silent = true })
-- vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true })
-- vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true })

-- Send single character deletes to the black hole register
vim.keymap.set("n", "x", '"_x')

-- Send 'change' operations to the black hole register
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')

-- 1. Unmap default Ctrl+Arrow resizing
vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")

-- 2. Bind Ctrl + Shift + Arrows to Resize Panes
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- 3. Bind Ctrl + Arrows to Navigate Between Panes/Splits
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Go to Right Window" })

-- 4. Testing
-- Navigate buffers using Shift + Left/Right arrows
vim.keymap.set("n", "<S-Left>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-Right>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
