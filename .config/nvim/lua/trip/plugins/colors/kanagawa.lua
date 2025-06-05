return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("kanagawa").setup({
			transparent = true,
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
		})
		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
