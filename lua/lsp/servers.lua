-- lspconfig
local lspconfig = require('lspconfig')

local remaps = require('lsp.remaps')

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	remaps.remap_for_buffer(bufnr)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
