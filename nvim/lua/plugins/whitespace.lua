return {
    'johnfrankmorgan/whitespace.nvim',
    config = function ()
        require('whitespace-nvim').setup()
		local wk = require("which-key")
		wk.add({
            { "gW", function() require('whitespace-nvim').trim() end, desc = "Trim trailing [W]hitespaces" }
        })
	end
}
