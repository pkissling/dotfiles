-- set leader key
vim.g.mapleader = "space"

-- set tabs and indent
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- set line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- keymap
vim.keymap.set("n", "<ESC>", ":nohlsearch<CR>") -- clear search highlight

-- save undo history
vim.opt.undofile = true

-- init lazy.nvim
require("config.lazy")

