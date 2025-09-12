--- A utility class to construct cmake commands easily
--- @class CmakeCmdBuilder
--- @field private _instance CmakeInstance The cmake instance
--- @field private _cmd string[] The accumulated command arguments
local CmakeCmdBuilder = {}

--- Creates a CmakeCmdBuilder
--- @param instance CmakeInstance The cmake instance
--- @return CmakeCmdBuilder # The command builder
function CmakeCmdBuilder:new(instance)
	local new = setmetatable({
		_instance = instance,
		_cmd = { 'cmake' },
	}, self)
	self.__index = self

	return new
end

--- Adds an argument to the current command
--- @param arg string The argument to add
--- @return CmakeCmdBuilder # This builder. Used for chaining
function CmakeCmdBuilder:add_argument(arg)
	table.insert(self._cmd, arg)
	return self
end

--- Generates a generation command with the information from the instance
--- @return CmakeCmdBuilder # This builder. Used for chaining
function CmakeCmdBuilder:generate()
	return self:add_argument('-S')
		:add_argument(self._instance.root_dir)
		:add_argument('-B')
		:add_argument(self._instance.build_dir)
end

--- Generates a build command with the information from the instance
--- @return CmakeCmdBuilder # This builder. Used for chaining
function CmakeCmdBuilder:build()
	return self:add_argument('--build')
		:add_argument(self._instance.build_dir)
end

--- Builds the command
--- @return string[] # The command
function CmakeCmdBuilder:cmd()
	return self._cmd
end


return CmakeCmdBuilder
