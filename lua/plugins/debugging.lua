return {
	{
		'mfussenegger/nvim-dap',
		name = 'dap',
		lazy = true,
		config = function ()
			require('debugging')
		end
	},
	{
		'rcarriga/nvim-dap-ui',
		name = 'dap-ui',
		dependencies = {'dap', 'nvim-neotest/nvim-nio'},
		lazy = true
	},
}
