local mason_bin_dir = vim.fs.normalize(vim.fn.stdpath("data") .. "/mason/bin")
local jdtls_bin_path = vim.fs.find("jdtls", {
	path = mason_bin_dir
})[1]

local config = {
    cmd = { jdtls_bin_path },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
	on_attach = function (_, bufnr)
		require('lsp.remaps').remap_for_buffer(bufnr)
	end
}
require('jdtls').start_or_attach(config)

print("ftplugin/java.lua has been ran")
