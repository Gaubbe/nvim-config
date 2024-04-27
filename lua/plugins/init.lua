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

}
