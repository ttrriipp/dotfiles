return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font, lazy = true },
	},
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
	end,
	keys = function()
		local builtin = require("telescope.builtin")
		return {
			{ "<leader>sh", builtin.help_tags, desc = "[S]earch [H]elp" },
			{ "<leader>sk", builtin.keymaps, desc = "[S]earch [K]eymaps" },
			{ "<leader>sf", builtin.find_files, desc = "[S]earch [F]iles" },
			{ "<leader>sc", builtin.colorscheme, desc = "[S]earch [C]olorscheme" },
			{ "<leader>sw", builtin.grep_string, desc = "[S]earch current [W]ord" },
			{ "<leader>sg", builtin.live_grep, desc = "[S]earch by [G]rep" },
			{ "<leader>sd", builtin.diagnostics, desc = "[S]earch [D]iagnostics" },
			{ "<leader>sb", builtin.buffers, desc = "[S]earch [B]uffers" },
			{ "<leader>gf", builtin.git_files, desc = "[G]it [F]iles" },
			{ "<leader>gb", builtin.git_branches, desc = "[G]it [B]ranches" },
			{
				"<leader>/",
				function()
					builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				desc = "[/] Fuzzily search in current buffer",
			},
			{
				"<leader>sn",
				function()
					builtin.find_files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "[S]earch [N]eovim files",
			},
		}
	end,
}
