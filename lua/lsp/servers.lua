require('mason').setup()
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig');

lspconfig.sumneko_lua.setup{}

