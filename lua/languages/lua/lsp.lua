local utils = require('lsp.utils')
local mason = require('utils.mason.constants')

vim.lsp.config('lua_ls', {
	on_attach = utils.on_attach,
	capabilities = utils.capabilities,
	cmd = { mason.find_in_mason_bin_dir('lua-language-server') },
})
vim.lsp.enable('lua_ls')
