return {
	'nvim-telescope/telescope.nvim',
	name = 'telescope',
	version = "^0.1.6",
	dependencies = {'nvim-lua/plenary.nvim'},
	cmd = 'Telescope',
	keys = '<Leader>t',
	config = function ()
		require('telescope-conf.setup')
		require('telescope-conf.remaps')
	end
}
