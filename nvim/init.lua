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
vim.keymap.set("n", "<leader>l", ":Lazy<CR>") -- open lazy.nvim

-- save undo history
vim.opt.undofile = true

-- visualize whitespace chars
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- highlight line with cursor
vim.opt.cursorline = true

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- init lazy.nvim
require("config.lazy")

