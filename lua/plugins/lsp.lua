return {
	{
		'neovim/nvim-lspconfig',
		name = 'lspconfig',
		dependencies = { 'mason-lspconfig' },
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		keys = "<Leader>l",
		config = function ()
			require('lsp')
		end
	}
}
