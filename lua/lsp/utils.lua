local lspconfig = require('lspconfig')

local remaps = require('lsp.remaps')

local M = {}

M.on_attach = function(_, bufnr)
	vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
	remaps.remap_for_buffer(bufnr)
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M
