local normalized_data_dir = vim.fs.normalize(vim.fn.stdpath("data"))
local jdtls_bin_path = vim.fs.find("mason/bin/jdtls", {
	path = normalized_data_dir
})

local config = {
    cmd = { jdtls_bin_path },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)

print("ftplugin/java.lua has been ran")
