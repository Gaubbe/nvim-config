vim.cmd([[colorscheme gruvbox]])

require'nvim-treesitter.configs'.setup {
	ensure_installed = { 'rust', 'lua', 'vim' },

	highlight = {
		enable = true
	}
}
