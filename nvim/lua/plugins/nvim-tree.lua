return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "[E]xplore" }
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
	config = function()
		require("nvim-tree").setup { }
	end
}
