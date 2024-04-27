return {
	-- Colorscheme
	{
		'ellisonleao/gruvbox.nvim',
		config = function() vim.cmd[[colorscheme gruvbox]] end
	},

	'nvim-treesitter/nvim-treesitter',

	-- jdtls
	'mfussenegger/nvim-jdtls',

	-- cmp
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'L3MON4D3/LuaSnip',

	-- dap
	'mfussenegger/nvim-dap',
	{'rcarriga/nvim-dap-ui', dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'}},
}
