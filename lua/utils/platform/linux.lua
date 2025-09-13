--- @class LinuxPlatform : IPlatform
local M = {}

--- Returns a command that creates a symlink
--- @param orig string The filepath to the original file
--- @param link string The filepath to the link
--- @return string[] # The command to run
M.create_symlink_cmd = function (orig, link)
	return {
		'ln',
		'-s',
		vim.fs.normalize(orig),
		vim.fs.normalize(link),
	}
end

return M
