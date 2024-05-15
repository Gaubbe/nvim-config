return {
	{
		'Civitasv/cmake-tools.nvim',
		name = "cmake-tools",
		cond = function()
			local cwd = vim.fn.getcwd()
			local cmake_file = vim.fs.find(function (name, path)
				return name:match("CMakeLists.txt") and path == cwd
			end, {
				path = cwd
			})

			return next(cmake_file) ~= nil
		end,
		config = function ()
			local build_directory = "build/${variant:buildType}"

			if vim.loop.os_uname().sysname:find("Windows") then
				build_directory = "build\\${variant:buildType}"
			end

			require("cmake-tools").setup({
				cmake_build_directory = build_directory
			})
		end
	}
}
