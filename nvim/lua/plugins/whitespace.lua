return {
    'johnfrankmorgan/whitespace.nvim',
    config = function ()
        require('whitespace-nvim').setup()
		local wk = require("which-key")
		wk.add({
            { "<leader>t", function() require('whitespace-nvim').trim() end, desc = "[T]rim trailing whitespaces" }
        })
	end
}
