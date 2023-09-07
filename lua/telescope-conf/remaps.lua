local function telescope_map(mode, rhs, lhs, opts)
	vim.keymap.set(mode, '<Leader>t' .. rhs, lhs, opts)
end

local builtin = require('telescope.builtin')
local opts = { noremap = true, silent = true }
telescope_map('n', 'f', builtin.find_files, opts)
telescope_map('n', 'g', builtin.git_files, opts)
telescope_map('n', 'b', builtin.git_branches, opts)
telescope_map('n', 'd', builtin.diagnostics, opts)
