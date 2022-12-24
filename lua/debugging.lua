-- Remaps
local function dapmap(mode, lhs, rhs, opts)
	vim.keymap.set(mode, "<Leader>d" .. lhs, rhs, opts)
end

local opts = { silent = true, noremap = true }

dapmap('n', 'b', '<Cmd>DapToggleBreakpoint<CR>', opts)

vim.keymap.set('n', '<F5>', '<Cmd>DapContinue<CR>', opts)
vim.keymap.set('n', '<F10>', '<Cmd>DapStepOver<CR>', opts)
vim.keymap.set('n', '<F11>', '<Cmd>DapStepInto<CR>', opts)

-- Adapters

local dap = require'dap'

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

-- UI
local dapui = require('dapui')
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function ()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function ()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function ()
	dapui.close()
end
