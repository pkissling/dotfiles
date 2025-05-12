return {
   "mason-org/mason.nvim",
   dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig"
   },
   opts = {
      servers = {
         lua_ls = {
            settings = {
               Lua = {
                  diagnostics = {
                     globals = { "vim" }
                  }
               }
            }
         }
      }
   },
   config = function(_, opts)
      require('mason').setup()
      require('mason-lspconfig').setup({
         ensure_installed = { "lua_ls" },
      })

      vim.diagnostic.config({
         virtual_text = true
      })

      for server, config in pairs(opts.servers) do
         vim.lsp.config(server, config)
      end

      -- keymaps
      local wk = require("which-key")
      wk.add({
         { "<leader>m", cmd = "<cmd>Mason<cr>", desc = "[M]ason" }
      })
   end
}
