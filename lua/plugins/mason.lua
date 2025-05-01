return {
	{
		'williamboman/mason.nvim',
		cmd = {
			'Mason',
			'MasonInstall',
			'MasonLog',
			'MasonUninstall',
			'MasonUninstallAll',
			'MasonUpdate'
		},
		name = "mason",
		version = '^1.10.0',
		config = function ()
			require('mason').setup()
		end
	},
}
