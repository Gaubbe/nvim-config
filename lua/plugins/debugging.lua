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
		keys = {
			'<Leader>d',
			'<F5>',
			'<F10>',
			'<F11>',
			'<F12>'
		},
		config = function ()
			require('debugging.ui')
		end
	},
}
