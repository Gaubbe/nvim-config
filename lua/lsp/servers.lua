require('mason').setup()
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig');

local lspmap = function(mode, rhs, lhs, opts)
	vim.keymap.set(mode, "<Leader>l" .. rhs, lhs, opts)
end

local opts = { silent = true, noremap = true }

lspmap("n", "f", vim.diagnostic.open_float, opts)
lspmap("n", "n", vim.diagnostic.goto_next, opts)
lspmap("n", "N", vim.diagnostic.goto_prev, opts)

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { silent = true, noremap = true, buffer = bufnr }
	lspmap('n', 'd', vim.lsp.buf.definition, bufopts)
	lspmap('n', 'D', vim.lsp.buf.declaration, bufopts)
	lspmap('n', 'h', vim.lsp.buf.hover, bufopts)
	lspmap('n', 'i', vim.lsp.buf.implementation, bufopts)
	lspmap('n', 's', vim.lsp.buf.signature_help, bufopts)
	lspmap('n', 't', vim.lsp.buf.type_definition, bufopts)
	lspmap('n', 'r', vim.lsp.buf.rename, bufopts)
	lspmap('n', 'a', vim.lsp.buf.code_action, bufopts)
	lspmap('n', 'R', vim.lsp.buf.references, bufopts)
	lspmap('n', 'F', function() vim.lsp.buf.format{ async = true } end, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lspconfig.sumneko_lua.setup {
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

