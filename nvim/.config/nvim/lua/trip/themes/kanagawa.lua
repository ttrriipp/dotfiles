return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("kanagawa").setup({
			transparent = true,
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
					TelescopeNormal = { bg = "none" },
					TelescopeBorder = { bg = "none" },
					BlinkCmpMenu = { fg = theme.ui.fg, bg = "none" },
					BlinkCmpMenuSelection = { fg = "NONE", bg = theme.ui.bg_p2 },
					BlinkCmpMenuBorder = { fg = theme.ui.float.fg_border, bg = "none" },
					BlinkCmpDoc = { fg = theme.ui.fg, bg = "none" },
					BlinkCmpDocBorder = { fg = theme.ui.float.fg_border, bg = "none" },
					BlinkCmpSignatureHelp = { fg = theme.ui.fg, bg = "none" },
					BlinkCmpSignatureHelpBorder = { fg = theme.ui.float.fg_border, bg = "none" },
					BlinkCmpLabel = { fg = theme.ui.fg },
					BlinkCmpLabelMatch = { fg = theme.syn.fun, bold = true },
					BlinkCmpKind = { fg = theme.syn.type },
					BlinkCmpSource = { fg = theme.ui.fg_dim },
					Visual = { bg = theme.ui.bg_p2 },
				}
			end,
		})

		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
