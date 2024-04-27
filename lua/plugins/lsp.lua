return {
	{
		'folke/neodev.nvim',
		name = 'neodev',
		lazy = true,
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
	}
}
