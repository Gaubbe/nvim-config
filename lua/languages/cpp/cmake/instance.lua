local CmakeCmdBuilder = require('languages.cpp.cmake.cmd_builder')
local async = require('utils.async')
local platform = require('utils.platform')

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

--- Returns a command builder
--- @return CmakeCmdBuilder # The command builder
function CmakeInstance:cmd_builder()
	return CmakeCmdBuilder:new(self)
end

--- @async
--- Initializes the cmake project
function CmakeInstance:init_project()
	local generate_cmd = self:cmd_builder():generate()
		:add_argument('-G')
		:add_argument('Ninja')
		:add_argument('-DCMAKE_EXPORT_COMPILE_COMMANDS=ON')
		:cmd()

	async.system(generate_cmd, {
		cwd = self.root_dir,
	})

	local link_cmd = platform.create_symlink_cmd(
		self.build_dir .. '/compile_commands.json',
		self.root_dir .. '/compile_commands.json'
	)

	async.system(link_cmd, {
		cwd = self.root_dir,
	})
end

return CmakeInstance
