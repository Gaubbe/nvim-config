local function dapmap(mode, lhs, rhs, opts)
	vim.keymap.set(mode, "<Leader>d" .. lhs, rhs, opts)
end

local opts = { silent = true, noremap = true }

dapmap('n', 'b', '<Cmd>DapToggleBreakpoint<CR>', opts)

vim.keymap.set('n', '<F5>', '<Cmd>DapContinue<CR>', opts)
vim.keymap.set('n', '<F10>', '<Cmd>DapStepOver<CR>', opts)
vim.keymap.set('n', '<F11>', '<Cmd>DapStepInto<CR>', opts)
vim.keymap.set('n', '<F12>', '<Cmd>DapStepOut<CR>', opts)
