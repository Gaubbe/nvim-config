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

--- Returns iterator of lines in string
---@param str string
---@return fun(): string?
local lines = function(str)
	local from = 1
	local delim_from, delim_to = string.find(str, '\n', from)
	return function ()
		if delim_from ~= nil then
			local result = string.sub(str, from, delim_from - 1)
			from = delim_to + 1
			delim_from, delim_to = string.find(str, '\n', from)
			return result
		end
	end
end

--- Builds a target from a package
---@param package_name string
---@param target_name string
---@param on_exit fun(messages: (CargoBuildMessage)[])
---@param tests boolean?
function CargoInstance:build(package_name, target_name, on_exit, tests)
	if tests == nil then
		tests = false
	end

	vim.system({
		'cargo',
		'build',
		'--message-format',
		'json',
	}, {
		cwd = self.root_dir,
	}, function(out)
		---@type (CargoBuildMessage)[]
		local messages = {}

		for l in lines(out.stdout) do
			table.insert(messages, cargo_json_decode(l))
		end

		on_exit(messages)
	end)
end

return CargoInstance
