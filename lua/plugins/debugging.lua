return {
	{
		'mfussenegger/nvim-dap',
		name = 'dap',
		lazy = true,
		config = function ()
			require('debugging')
			require('debugging.ui')
		end,
	},
	{
		'rcarriga/nvim-dap-ui',
		name = 'dap-ui',
		dependencies = {'dap', 'nvim-neotest/nvim-nio'},
		lazy = true,
	},
}
