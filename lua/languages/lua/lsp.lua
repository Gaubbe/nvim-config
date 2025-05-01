local utils = require('lsp.utils')
vim.lsp.config('lua_ls',{
	on_attach = utils.on_attach,
	capabilities = utils.capabilities,
})
vim.lsp.enable('lua_ls')
