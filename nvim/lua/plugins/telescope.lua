return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim"
	},
	config = function()
		local wk = require("which-key")
		wk.add({
            { "<leader>s", group = "[S]earch" },
            { "<leader>sf", cmd = "<cmd>Telescope find_files<cr>", desc = "[F]iles" },
            { "<leader>sg", cmd = "<cmd>Telescope live_grep<cr>", desc = "[G]rep" },
            { "<leader><space>", cmd = "<cmd>Telescope buffers<cr>", desc = "Recent Files" }
        })
	end
}
