-- luacheck: globals vim

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      search = {
        enabled = true,
        highlight = { backdrop = true }
      }
    }
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  config = function(_, opts)
    local palette = require('gruvbox').palette
    vim.api.nvim_command("hi FlashLabel guibg=" .. palette.faded_yellow .. " guifg=" .. palette.dark_red_hard)
    require("flash").setup(opts)
  end
}
