local M = {}

--- Checks whether a crate type is a lib type
---@param crate_type CargoCrateType
---@return boolean
M.is_lib_type = function (crate_type)
	return crate_type == 'lib'
		or crate_type == 'dylib'
		or crate_type == 'staticlib'
		or crate_type == 'cdylib'
		or crate_type == 'rlib'
		or crate_type == 'proc-macro'
end

return M
