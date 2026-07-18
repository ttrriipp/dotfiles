return {
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("everforest").setup({
			background = "soft",
			transparent_background_level = 2,
			on_highlights = function(hl, palette)
				hl.NormalFloat = { fg = palette.fg, bg = palette.none }
				hl.FloatBorder = { fg = palette.grey1, bg = palette.none }
				hl.FloatTitle = { fg = palette.grey1, bg = palette.none }
				hl.TelescopeNormal = { fg = palette.fg, bg = palette.none }
				hl.TelescopeBorder = { fg = palette.grey1, bg = palette.none }
				hl.BlinkCmpMenu = { fg = palette.fg, bg = palette.none }
				hl.BlinkCmpMenuBorder = { fg = palette.grey1, bg = palette.none }
				hl.BlinkCmpDoc = { fg = palette.fg, bg = palette.none }
				hl.BlinkCmpDocBorder = { fg = palette.grey1, bg = palette.none }
				hl.BlinkCmpSignatureHelp = { fg = palette.fg, bg = palette.none }
				hl.BlinkCmpSignatureHelpBorder = { fg = palette.grey1, bg = palette.none }
			end,
		})

		vim.cmd.colorscheme("everforest")
	end,
}
