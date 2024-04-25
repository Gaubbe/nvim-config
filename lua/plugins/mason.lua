return {
	{
		'williamboman/mason.nvim',
		cmd = "Mason",
		name = "mason",
		config = function ()
			require('mason').setup()
		end
	},
	{
		'williamboman/mason-lspconfig.nvim',
		name = 'mason-lspconfig',
		dependencies = {'mason'},
		cmd = "LspInstall",
		config = function ()
			require('mason-lspconfig').setup({
				automatic_installation = true
			})
		end
	}
}
