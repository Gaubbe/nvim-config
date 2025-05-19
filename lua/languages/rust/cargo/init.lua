local M = {}

--- Creates the cargo related user commands
--- @param client vim.lsp.Client
--- @param bufnr integer
M.create_cargo_user_commands = function (client, bufnr)
	local cargo = require('languages.rust.cargo.instance'):new(client.root_dir)

	vim.api.nvim_buf_create_user_command(bufnr, 'CargoRootDir', function ()
		vim.print(vim.inspect(client.root_dir))
	end, {})
	vim.api.nvim_buf_create_user_command(bufnr, 'CargoMetadata', function ()
		vim.print(vim.inspect(cargo:get_metadata()))
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
		local metadata = cargo:get_metadata()
		require('languages.rust.cargo.target_picker').target_picker(metadata, function(entry)
			cargo:build(entry[1], entry[2], on_exit, entry[3])
		end)
	end, {})
end

return M
