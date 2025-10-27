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
	local running = true

	local res = vim.system(cmd, opts, function (completed)
		running = false
		ret = completed
		if coroutine.status(this) == "suspended" then
			coroutine.resume(this)
		end
	end)

	if running then
		coroutine.yield(res)
	end

	--- @cast ret vim.SystemCompleted
	return ret
end

return M
