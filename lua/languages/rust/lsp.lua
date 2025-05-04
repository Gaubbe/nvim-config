local utils = require('lsp.utils')

---@param client vim.lsp.Client
---@param bufnr integer
local on_attach = function (client, bufnr)
	utils.on_attach(client, bufnr)
	require('languages.rust.cargo').create_cargo_user_commands(client, bufnr)
end

vim.lsp.config('rust_analyzer', {
	on_attach = on_attach,
	capabilities = utils.capabilities,
})
vim.lsp.enable('rust_analyzer')
