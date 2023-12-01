local data_stdpath = vim.fn.stdpath("data")

-- Finding mason packages directory
local mason_packages_dir = vim.fs.normalize(data_stdpath .. "/mason/packages")

-- Finding jdtls install location
local jdtls_install_dir = vim.fs.normalize(mason_packages_dir .. "/jdtls")

-- Finding jdtls launcher jar
local jdtls_laucher_path = vim.fs.find(function(name, path)
	return name:match("org%.eclipse%.equinox%.launcher_.")
end, { path = vim.fs.normalize(jdtls_install_dir .. "/plugins") })[1]

-- Finding os specific config location
local jdtls_config_dir = (function ()
	-- Finding config location
	local os_info = vim.loop.os_uname()
	if string.find(os_info.sysname, "Windows") then
		return jdtls_install_dir .. "/config_win"
	elseif string.find(os_info.sysname, "Linux") then
		return jdtls_install_dir .. "/config_win"
	end

	return ""
end)()

-- Finding java-debug plugin file
local java_debug_file = vim.fn.glob(mason_packages_dir .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar");

-- Defining workspace path
local root_dir = require("jdtls.setup").find_root({'.git', 'mvnw', 'gradlew'})
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fs.normalize(data_stdpath .. "/jdtls-workspaces/" .. project_name)

-- Actual configuration
local config = {
    cmd = {

		'java',

		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

		'-jar', jdtls_laucher_path,

		'-configuration', jdtls_config_dir,

		'-data', workspace_dir
	},

	on_attach = function (_, bufnr)
		require('lsp.remaps').remap_for_buffer(bufnr)
	end,

	init_options = {
		bundles = {
			java_debug_file
		}
	}
}
require('jdtls').start_or_attach(config)
