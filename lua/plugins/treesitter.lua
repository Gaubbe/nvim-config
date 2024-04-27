return {
	{
		'nvim-treesitter/nvim-treesitter',
		name = 'treesitter',
		-- Might be possible to make lazy
		config = function()
			require('treesitter-conf')

			vim.cmd[[TSUpdate]]
		end
	}
}
