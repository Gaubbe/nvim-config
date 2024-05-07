require'nvim-treesitter.configs'.setup {
	ensure_installed = { 'rust', 'lua', 'vim', 'java', 'cpp' },

	highlight = {
		enable = true
	}
}
