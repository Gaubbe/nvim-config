--- An instance of the cargo workspace
--- @class CargoInstance
--- @field public root_dir string The root directory of the cargo workspace
local CargoInstance = {}

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
		metadata = vim.json.decode(obj.stdout, {
			luanil = {
				object = true,
				array = true,
			}
		})
	end

	return metadata
end

end

return CargoInstance
