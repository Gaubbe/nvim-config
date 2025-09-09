local utils = require('lsp.utils')
local mason = require('utils.mason.constants')

---@param client vim.lsp.Client
---@param bufnr integer
local on_attach = function (client, bufnr)
	utils.on_attach(client, bufnr)
end

vim.lsp.config('clangd', {
	on_attach = on_attach,
	capabilities = utils.capabilities,
	cmd = { mason.find_in_mason_bin_dir('clangd') }
})
vim.lsp.enable('clangd')
