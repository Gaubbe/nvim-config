local utils = require('lsp.utils')
vim.lsp.config('rust_analyzer', {
	on_attach = utils.on_attach,
	capabilities = utils.capabilities,
})
vim.lsp.enable('rust_analyzer')
