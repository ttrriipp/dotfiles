return {
	---@type snacks.Config
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		scratch = {},
	},
	keys = {
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				-- Snacks.scratch.select()
				require("trip.utils.scratch").select_scratch()
			end,
			desc = "Select Scratch Buffer",
		},
	},
}
