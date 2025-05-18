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
					print(v.executable)
				end
			end
		end
		local metadata = cargo:get_metadata()
		cargo:build(metadata.packages[1].name, metadata.packages[1].targets[1], on_exit, true)
	end, {})
end

return M
