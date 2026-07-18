return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
		"TmuxNavigatorProcessList",
	},
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Move focus to the left pane" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Move focus to the lower pane" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Move focus to the upper pane" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Move focus to the right pane" },
	},
}
