require('mason').setup()
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig');

local lspmap = function(mode, rhs, lhs, opts)
	vim.keymap.set(mode, "<Leader>l" .. rhs, lhs, opts)
end

local gopts = { silent = true, noremap = true }

lspmap("n", "f", vim.diagnostic.open_float, gopts)
lspmap("n", "n", vim.diagnostic.goto_next, gopts)
lspmap("n", "N", vim.diagnostic.goto_prev, gopts)

lspconfig.sumneko_lua.setup{
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

