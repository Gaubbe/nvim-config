return {
	'nvim-telescope/telescope.nvim',
	version = "^0.1.6",
	dependencies = {'nvim-lua/plenary.nvim'},
	cmd = 'Telescope',
	init = function ()
		require('telescope-conf.remaps')
	end,
	config = function ()
		require('telescope-conf.setup')
	end
}
