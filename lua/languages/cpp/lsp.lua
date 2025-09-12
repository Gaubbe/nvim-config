local utils = require('lsp.utils')
local mason = require('utils.mason.constants')
local cmake = require('languages.cpp.cmake')

---@param client vim.lsp.Client
---@param bufnr integer
local on_attach = function (client, bufnr)
	utils.on_attach(client, bufnr)

	local is_cmake = vim.fs.find("CMakeLists.txt", {
		path = client.root_dir,
	})[1] ~= nil

	if is_cmake then
		local build_dir = vim.fs.normalize(client.root_dir .. '/build')
		local instance = cmake.CmakeInstance:new(client.root_dir, build_dir)
	end
end

vim.lsp.config('clangd', {
	on_attach = on_attach,
	capabilities = utils.capabilities,
	cmd = { mason.find_in_mason_bin_dir('clangd') }
})
vim.lsp.enable('clangd')
