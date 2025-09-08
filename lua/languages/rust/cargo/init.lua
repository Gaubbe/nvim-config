local M = {}

--- Creates the cargo related user commands
--- @param instance CargoInstance
--- @param bufnr integer
M.create_cargo_user_commands = function (instance, bufnr)
	vim.api.nvim_buf_create_user_command(bufnr, 'CargoRootDir', function ()
		vim.print(instance.root_dir)
	end, {})
	vim.api.nvim_buf_create_user_command(bufnr, 'CargoMetadata', function ()
		vim.print(vim.inspect(instance:get_metadata()))
	end, {})
	vim.api.nvim_buf_create_user_command(bufnr, 'CargoBuild', function ()
		---@param messages (CargoBuildMessage)[]
		local on_exit = function(messages)
			for _, v in pairs(messages) do
				if v.reason == "compiler-artifact" then
					print('compiler-artifact')
					print(v.executable)
				end
			end
		end
		local metadata = instance:get_metadata()
		require('languages.rust.cargo.target_picker').target_picker(metadata, function(entry)
			instance:build(entry[1], entry[2], on_exit, entry[3])
		end)
	end, {})
end

return M
