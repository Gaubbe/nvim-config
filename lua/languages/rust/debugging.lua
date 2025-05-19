local dap = require("dap")
local mason_constants = require("utils.mason.constants")

dap.adapters.codelldb = {
	type = 'server',
	port = '${port}',
	executable = {
		command = mason_constants.find_in_mason_bin_dir('codelldb'),
		args = { '--port', '${port}' },
	},
}
