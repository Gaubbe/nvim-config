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

--- Obtains all the runnables in this cargo project
--- @return CargoRunnable[] # The runnables
function CargoInstance:get_runnables()
	--- @type CargoRunnable[]
	local runnables = {}
	local metadata = self:get_metadata()

	for _, p in pairs(metadata.packages) do
		for _, t in pairs(p.targets) do
			-- Each target only ever seems to have one kind and crate-type
			-- TODO: actually check the whole array?

			if t.test and t.kind[1] ~= 'test' then
				--- @type CargoRunnable
				local r = {
					type = 'utest',
					name = t.name,
					project = p.name,
				}
				table.insert(runnables, r)
			end

			if t.kind[1] == 'test' then
				--- @type CargoRunnable
				local r = {
					type = 'itest',
					name = t.name,
					project = p.name,
				}
				table.insert(runnables, r)
			end

			if t.kind[1] == 'example' then
				--- @type CargoRunnable
				local r = {
					type = 'example',
					name = t.name,
					project = p.name,
				}
				table.insert(runnables, r)
			end

			if t.kind[1] == 'bin' then
				--- @type CargoRunnable
				local r = {
					type = 'bin',
					name = t.name,
					project = p.name,
				}
				table.insert(runnables, r)
			end
		end
	end

	return runnables
end

return CargoInstance
