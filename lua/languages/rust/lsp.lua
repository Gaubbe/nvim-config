local lsp_utils = require('lsp.utils')
vim.lsp.config('rust_analyzer', {
	on_attach = lsp_utils.on_attach,
	capabilities = lsp_utils.capabilities,
})
vim.lsp.enable('rust_analyzer')
