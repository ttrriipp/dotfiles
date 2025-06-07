return {
	"webhooked/kanso.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("kanso").setup({
			transparent = true,
		})
		vim.cmd.colorscheme("kanso-zen")
	end,
}
