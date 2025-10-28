--- @class IPlatform
--- @field create_symlink_cmd fun(orig: string, link: string): string[] Returns a command that creates a symlink
--- @field set_shell_options fun() Sets-up shell neovim options
local M = {}

local sysname = vim.uv.os_uname().sysname

if sysname == 'Windows_NT' then
	M = require('utils.platform.windows')
elseif sysname == 'Linux' then
	M = require('utils.platform.linux')
else
	assert(false, 'Unsupported OS')
end

return M
