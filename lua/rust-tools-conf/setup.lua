local rt = require("rust-tools")

local extension_path = require('utils.mason.constants').append_to_mason_packages_dir("codelldb/extension")
local codelldb_path = vim.fs.normalize(extension_path .. "/adapter/codelldb")
local liblldb_path = vim.fs.normalize(extension_path .. "/lldb/lib/liblldb.so")

local this_os = vim.loop.os_uname().sysname

if this_os:find "Windows" then
	codelldb_path = vim.fs.normalize(extension_path .. "/adapter/codelldb.exe")
	-- codelldb doesn't like non-windows
	liblldb_path = string.gsub(vim.fs.normalize(extension_path .. "/lldb/bin/liblldb.dll"), "/", "\\")
end

local opts = {
	dap = {
		adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
	}
}

rt.setup(opts)
