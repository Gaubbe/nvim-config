local utils = require('lsp.utils')

---@param client vim.lsp.Client
---@param bufnr integer
local on_attach = function (client, bufnr)
	utils.on_attach(client, bufnr)
end

vim.lsp.config('pyright', {
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
