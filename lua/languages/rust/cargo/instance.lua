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

--- Checks whether a value is contained within an array
--- @generic T
--- @param tab T[] The table to check
--- @param value T The value
local contains = function(tab, value)
	for _, v in ipairs(tab) do
		if v == value then
			return true
		end
	end
	return false
end

--- Obtains all the runnables in this cargo project
--- @return CargoRunnable[] # The runnables
function CargoInstance:get_runnables()
	--- @type CargoRunnable[]
	local runnables = {}
	local metadata = self:get_metadata()

	for _, p in pairs(metadata.packages) do
		for _, t in pairs(p.targets) do
			-- TODO: Support other kinds of targets
			if contains(t.kind, 'bin') then
				table.insert(runnables, {
					name = t.name,
					type = 'bin',
					project = p.name,
				})
			end
		end
	end

	return runnables
end

return CargoInstance
