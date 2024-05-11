-- Adapters
local dap = require('dap')
local mason_constants = require('utils.mason.constants')

dap.adapters.codelldb = {
	type = 'server',
	port = '${port}',

	executable = {
		command = vim.fs.find(function(name, _)
			return name:match("codelldb.*")
		end, {
			path = mason_constants.get_mason_bin_dir()
		})[1],
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

