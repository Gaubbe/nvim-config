local utils = require('lsp.utils')
local mason = require('utils.mason.constants')

---@param client vim.lsp.Client
---@param bufnr integer
local on_attach = function (client, bufnr)
	utils.on_attach(client, bufnr)
end

vim.lsp.config('pyright', {
	cmd = { mason.append_to_mason_bin_dir('pyright-langserver'), '--stdio'},
	on_attach = on_attach,
	capabilities = utils.capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "standard",
				diagnosticSeverityOverrides = {
					reportMissingImports = "error",
					reportMissingTypeStubs = "error",
				},
			},
		},
	}
})
vim.lsp.enable('pyright')
