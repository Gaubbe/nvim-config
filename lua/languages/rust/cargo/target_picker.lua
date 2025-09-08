local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local cargo_utils = require("languages.rust.cargo.utils")

local M = {}
---@alias TargetEntry [string, CargoTarget, boolean]

--- Opens a telescope picker to select a target to build
---@param metadata CargoMetadata
---@param on_select fun(entry: TargetEntry)
M.target_picker = function (metadata, on_select)
	---@type TargetEntry
	local entries = {}

	for p=1,#metadata.packages do
		local package = metadata.packages[p]
		for t=1,#package.targets do
			local target = package.targets[t]
			if not cargo_utils.is_lib_type(target.crate_types[1]) then
				table.insert(entries, {
					package.name,
					target,
					false
				})
			end

			if target.kind[1] == "bin" or cargo_utils.is_lib_type(target.crate_types[1]) then
				table.insert(entries, {
					package.name,
					target,
					true
				})
			end
		end
	end

	---@param entry TargetEntry
	---@return string
	local entry_maker_display = function (entry)
		local result = '[' .. entry[1] .. '] ' .. entry[2].name
		if entry[3] then
			result = result .. ' (unittest)'
		elseif entry[2].kind[1] == "bin" then
			result = result .. ' (bin)'
		elseif entry[2].kind[1] == "example" then
			result = result .. ' (example)'
		elseif entry[2].kind[1] == "test" then
			result = result .. ' (test)'
		elseif entry[2].kind[1] == "bench" then
			result = result .. ' (bench)'
		end

		return result
	end

	pickers.new({}, {
		prompt_title = 'Target Selection',
		finder = finders.new_table({
			results = entries,
			entry_maker = function(entry)
				local result = entry_maker_display(entry)
				return {
					value = entry,
					display = result,
					ordinal = result,
				}
			end,
		}),
		sorter = conf.generic_sorter({}),
		attach_mappings = function (prompt_bufnr, _)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				on_select(selection.value)
			end)
			return true
		end
	}):find()
end

return M

