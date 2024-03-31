return {
	{
		'williamboman/mason.nvim',
		cmd = "Mason",
		config = function ()
			require('mason').setup()
		end
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {'williamboman/mason.nvim'},
		cmd = "LspInstall",
		config = function ()
			require('mason-lspconfig').setup({
				automatic_installation = true
			})
		end
	}
}
