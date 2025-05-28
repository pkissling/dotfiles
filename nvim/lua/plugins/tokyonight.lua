-- luacheck: globals vim

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    local colors = require("tokyonight.colors").setup()
    vim.api.nvim_command("hi FlashLabel guibg=" .. colors.fg_dark .. " guifg=" .. colors.bg_dark)
    vim.cmd[[colorscheme tokyonight]]
  end
}
