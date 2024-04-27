return {
	{
		'ellisonleao/gruvbox.nvim',
		name = 'gruvbox',
		config = function() vim.cmd[[colorscheme gruvbox]] end
	},

	-- jdtls
	'mfussenegger/nvim-jdtls',

	-- dap
	'mfussenegger/nvim-dap',
	{'rcarriga/nvim-dap-ui', dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'}},
}
