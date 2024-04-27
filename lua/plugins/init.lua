return {
	{
		'ellisonleao/gruvbox.nvim',
		name = 'gruvbox',
		config = function() vim.cmd[[colorscheme gruvbox]] end
	},

	{
		'mfussenegger/nvim-jdtls',
		ft = 'java',
		config = function() require('ftplugin.java') end
	},

	-- dap
	'mfussenegger/nvim-dap',
	{'rcarriga/nvim-dap-ui', dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'}},
}
