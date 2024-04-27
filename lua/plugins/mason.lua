return {
	{
		'williamboman/mason.nvim',
		cmd = "Mason",
		name = "mason",
		version = '^1.10.0',
		config = function ()
			require('mason').setup()
		end
	},
	{
		'williamboman/mason-lspconfig.nvim',
		name = 'mason-lspconfig',
		version = '^1.28.0',
		dependencies = {'mason'},
		cmd = "LspInstall",
		config = function ()
			require('mason-lspconfig').setup({
				automatic_installation = true
			})
		end
	}
}
