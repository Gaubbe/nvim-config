-- lspconfig
local lspconfig = require('lspconfig')

local remaps = require('lsp.remaps')

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	remaps.remap_for_buffer(bufnr)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('neodev').setup({})

lspconfig.lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				}
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

lspconfig.omnisharp.setup {
	on_attach = on_attach,
	capabilities = capabilities
}
