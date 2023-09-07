---@diagnostic disable: missing-parameter
-- Icons
vim.fn.sign_define('DapBreakpoint', { text='', texthl='DiagnosticSignError', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', { text='', texthl='DiagnosticSignInfo'})

-- UI
local dapui = require('dapui')
local dap = require('dap')
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
