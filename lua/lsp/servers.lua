-- Mason
require('mason').setup()
require('mason-lspconfig').setup({
	automatic_installation = true -- Will install all servers that are configured through lspconfig
})

-- lspconfig
local lspconfig = require('lspconfig')

local remaps = require('lsp.remaps')

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	remaps.remap_for_buffer(bufnr)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
}

lspconfig.rust_analyzer.setup {
	on_attach = on_attach,
	capabilities = capabilities
}

lspconfig.tsserver.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
