--- @class WindowsPlatform : IPlatform
local M = {}

--- Returns a command that creates a symlink
--- @param orig string The filepath to the original file
--- @param link string The filepath to the link
--- @return string[] # The command to run
M.create_symlink_cmd = function (orig, link)
	-- For some reason, Windows requires admin privileges to create symlinks
	-- so we just create a copy
	return {
		'Copy-Item',
		'-Path',
		vim.fs.normalize(orig, {win = true}),
		'-Destination',
		vim.fs.normalize(link, {win = true}),
	}
end

--- Sets-up Neovim shell options
M.set_shell_options = function ()
	vim.o.shell = 'powershell.exe'
	vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
	vim.o.shellquote = ''
	vim.o.shellxquote = ''
end

return M
