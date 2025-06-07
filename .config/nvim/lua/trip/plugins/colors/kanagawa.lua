return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("kanagawa").setup({
			transparent = true,
			keywordStyle = { italic = false },
			compile = true,
			colors = {
				theme = {
					all = {
						ui = {
							float = {
								bg = "none",
							},
							bg_gutter = "none",
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
				}
			end,
		})
		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
