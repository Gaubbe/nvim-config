return {
	-- Colorscheme
	{
		'ellisonleao/gruvbox.nvim',
		config = function() vim.cmd[[colorscheme gruvbox]] end
	},

	'nvim-treesitter/nvim-treesitter',

	-- jdtls
	'mfussenegger/nvim-jdtls',

	-- dap
	'mfussenegger/nvim-dap',
	{'rcarriga/nvim-dap-ui', dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'}},
}
