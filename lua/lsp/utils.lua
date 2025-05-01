local lspconfig = require('lspconfig')

local remaps = require('lsp.remaps')

local M = {}

M.on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	remaps.remap_for_buffer(bufnr)
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M
