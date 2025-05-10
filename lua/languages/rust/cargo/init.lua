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
	vim.api.nvim_buf_create_user_command(bufnr, 'CargoRunnables', function ()
		vim.print(vim.inspect(cargo:get_runnables()))
	end, {})
end

return M
