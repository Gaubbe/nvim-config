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
			require("cmake-tools").setup({})
		end
	}
}
