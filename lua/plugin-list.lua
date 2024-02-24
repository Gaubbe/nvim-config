-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
	'wbthomason/packer.nvim',
	'folke/neodev.nvim',

	-- Colorscheme
	{
		'ellisonleao/gruvbox.nvim',
		config = function() vim.cmd[[colorscheme gruvbox]] end
	},

	'nvim-treesitter/nvim-treesitter',

	-- LSP
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'neovim/nvim-lspconfig',
	'onsails/lspkind.nvim',

	-- jdtls
	'mfussenegger/nvim-jdtls',

	-- cmp
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'L3MON4D3/LuaSnip',

	-- dap
	'mfussenegger/nvim-dap',
	'rcarriga/nvim-dap-ui',

	-- telescope
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = {'nvim-lua/plenary.nvim'}
	}
})
