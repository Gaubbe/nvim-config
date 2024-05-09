return {
	{
		'Civitasv/cmake-tools.nvim',
		name = "cmake-tools",
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
