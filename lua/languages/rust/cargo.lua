local M = {}

--- Obtains the metadata of the current workspace
--- @param client vim.lsp.Client The LSP client to use for the root directory
--- @return CargoMetadata # The metadata
M.get_metadata = function (client)
	--- @type CargoMetadata
	local metadata

	local obj = vim.system({
		'cargo',
		'metadata',
		'--no-deps',
		'--format-version',
		'1',
	},{
		cwd = client.root_dir,
	}):wait()

	if obj.stdout ~= nil then
		metadata = vim.json.decode(obj.stdout, {
			luanil = {
				object = true,
				array = true,
			}
		})
	end

	return metadata
end

--- Creates the cargo related user commands
--- @param client vim.lsp.Client
--- @param bufnr integer
M.create_cargo_user_commands = function (client, bufnr)
	vim.api.nvim_buf_create_user_command(bufnr, 'CargoRootDir', function ()
		vim.print(vim.inspect(client.root_dir))
	end, {})
	vim.api.nvim_buf_create_user_command(bufnr, 'CargoMetadata', function ()
		vim.print(vim.inspect(M.get_metadata(client)))
	end, {})
end

return M
