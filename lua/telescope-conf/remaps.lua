local function telescope_map(mode, rhs, lhs, opts)
	vim.keymap.set(mode, '<Leader>t' .. rhs, "<Cmd>Telescope " .. lhs .. "<CR>", opts)
end

local opts = { noremap = true, silent = true }
telescope_map('n', 'f', "find_files", opts)
telescope_map('n', 'g', "git_files", opts)
telescope_map('n', 'b', "git_branches", opts)
telescope_map('n', 'd', "diagnostics", opts)
