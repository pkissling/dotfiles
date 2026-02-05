-- luacheck: globals vim

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		auto_install = true,
		highlight = { enable = true },
	},
	config = function(_, opts)
		require('nvim-treesitter').setup(opts)

		-- Disable highlighting for large files
		vim.api.nvim_create_autocmd("BufReadPre", {
			callback = function(args)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.uv.fs_stat, args.file)
				if ok and stats and stats.size > max_filesize then
					vim.treesitter.stop(args.buf)
				end
			end,
		})
	end
}
