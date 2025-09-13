local M = {}

--- @async
--- Async wrapper around vim.system
--- @param cmd string[] The command to run
--- @param opts vim.SystemOpts The options
--- @return vim.SystemCompleted
M.system = function (cmd, opts)
	local this = coroutine.running()
	assert(this ~= nil, "async_system must be running inside a coroutine")

	--- @type vim.SystemCompleted?
	local ret = nil

	local system_obj = vim.system(cmd, opts, function (completed)
		ret = completed
		coroutine.resume(this)
	end)

	coroutine.yield(system_obj)

	--- @cast ret vim.SystemCompleted
	return ret
end

return M
