return {
	{
		'neovim/nvim-lspconfig',
		name = 'lspconfig',
		version = '^2.0.0',
		config = function ()
			require('lsp')
		end
	},
	{
		'hrsh7th/nvim-cmp',
		name = 'cmp',
		lazy = true
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		name = 'cmp-lsp',
		lazy = true
	},
	{
		'L3MON4D3/LuaSnip',
		name = 'LuaSnip',
		lazy = true
	},
}
