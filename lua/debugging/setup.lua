-- Adapters
local dap = require('dap')

dap.adapters.codelldb = {
	type = 'server',
	port = '${port}',

	executable = {
		command = 'C:\\Users\\Gabriel\\AppData\\Local\\nvim-data\\mason\\bin\\codelldb.cmd',
		args = {'--port', '${port}'}
	}
}

-- Configurations
dap.configurations.rust = {
	{
		type = 'codelldb',
		request = 'launch',
		name = 'Launch',

		program = function ()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false
	}
}

