--- An instance of the cmake workspace
--- @class CmakeInstance
--- @field public root_dir string The root directory of the cmake workspace
--- @field public build_dir string The build directory
local CmakeInstance = {}

--- Creates a new cmake instance
--- @param root_dir string The root directory of the cmake workspace
--- @param build_dir string The build directory
--- @return CmakeInstance # The instance
function CmakeInstance:new(root_dir, build_dir)
	local new = setmetatable({
		root_dir = root_dir,
		build_dir = build_dir,
	}, self)
	self.__index = self

	return new
end

return CmakeInstance
