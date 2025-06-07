return {
	"sainnhe/everforest",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.everforest_background = "soft"
		vim.g.everforest_float_style = "dim"
		vim.g.everforest_transparent_background = 2
		vim.g.everforest_enable_italic = true
		vim.cmd.colorscheme("everforest")
	end,
}
