return {
	{
		'onsails/lspkind.nvim',
		name = 'lspkind',
		lazy = true
	},
	{
		'folke/neodev.nvim',
		name = 'neodev',
		lazy = true,
		version = '^2.5.2',
		config = function ()
			require('neodev').setup({})
		end
	},
	{
		'neovim/nvim-lspconfig',
		name = 'lspconfig',
		dependencies = { 'mason-lspconfig', 'neodev' },
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		keys = "<Leader>l",
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
