--- An instance of the cargo workspace
--- @class CargoInstance
--- @field public root_dir string The root directory of the cargo workspace
local CargoInstance = {}

---@param str string
---@return any
local cargo_json_decode = function(str)
	return vim.json.decode(str, {
		luanil = {
			object = true,
			array = true,
		}
	})
end

--- Creates a new cargo instance
--- @param root_dir string The root directory of the cargo workspace
--- @return CargoInstance # The instance
function CargoInstance:new(root_dir)
	local new = setmetatable({
		root_dir = root_dir,
	}, self)
	self.__index = self

	return new
end

--- Obtains the metadata for this cargo project
--- @return CargoMetadata # The metadata
function CargoInstance:get_metadata()
	--- @type CargoMetadata
	local metadata

	local obj = vim.system({
		'cargo',
		'metadata',
		'--no-deps',
		'--format-version',
		'1',
	},{
		cwd = self.root_dir,
	}):wait()

	if obj.stdout ~= nil then
		metadata = cargo_json_decode(obj.stdout)
	end

	return metadata
end

--- Checks whether a crate type is a lib type
---@param crate_type CargoCrateType
---@return boolean
local is_lib_type = function (crate_type)
	return crate_type == 'lib'
		or crate_type == 'dylib'
		or crate_type == 'staticlib'
		or crate_type == 'cdylib'
		or crate_type == 'rlib'
		or crate_type == 'proc-macro'
end

return CargoInstance
