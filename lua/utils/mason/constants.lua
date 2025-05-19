local data_stdpath = vim.fn.stdpath("data")

local mason_dir = vim.fs.normalize(data_stdpath .. "/mason")

local mason_bin_dir = vim.fs.normalize(mason_dir .. "/bin")
local mason_packages_dir = vim.fs.normalize(mason_dir .. "/packages")
local mason_share_dir = vim.fs.normalize(mason_dir .. "/share")

local M = {}

M.get_data_stdpath = function ()
	return data_stdpath
end

M.get_mason_bin_dir = function ()
	return mason_bin_dir
end

M.get_mason_packages_dir = function ()
	return mason_packages_dir
end

M.get_mason_share_dir = function ()
	return mason_share_dir
end

M.append_to_mason_bin_dir = function (subdir)
	return vim.fs.normalize(mason_bin_dir .. "/" .. subdir)
end

M.append_to_mason_packages_dir = function (subdir)
	return vim.fs.normalize(mason_packages_dir .. "/" .. subdir)
end

M.append_to_mason_share_dir = function (subdir)
	return vim.fs.normalize(mason_share_dir .. "/" .. subdir)
end

---Finds an executable in the bin directory
---@param executable_name string
---@return string
M.find_in_mason_bin_dir = function (executable_name)
	return vim.fs.find(function (name, _)
		return string.match(name, executable_name) ~= nil
	end, {
		path = M.get_mason_bin_dir(),
	})[1]
end

return M
