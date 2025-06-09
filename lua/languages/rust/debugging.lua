local dap = require("dap")

local M = {}

--- Configures DAP with current cargo instance
---@param cargo_instance CargoInstance
M.configure_dap = function (cargo_instance)
	dap.configurations.rust = {
		{
			name = 'Launch',
			type = 'codelldb',
			request = 'launch',

			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			args = {},

			program = function ()
				return coroutine.create(function (dap_run_co)
					local target_picker = require('languages.rust.cargo.target_picker')
					local metadata = cargo_instance:get_metadata()

					target_picker.target_picker(metadata, function (entry)
						cargo_instance:build(entry[1], entry[2], function (compiler_messages)
							if compiler_messages[#compiler_messages] and compiler_messages[#compiler_messages].success then
								vim.print(compiler_messages[#compiler_messages - 1].executable)
								coroutine.resume(dap_run_co, compiler_messages[#compiler_messages - 1].executable)
							else
								vim.print('Build failed!')
								coroutine.resume(dap_run_co, dap.ABORT)
							end
						end, entry[3])
					end)
				end)
			end,
		}
	}
end

return M

