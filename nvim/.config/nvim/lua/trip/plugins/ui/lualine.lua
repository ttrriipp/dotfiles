return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = {
			fg = "#d5c4a1",
			gray = "#928374",
			red = "#cc241d",
			green = "#98971a",
			yellow = "#d79921",
			blue = "#458588",
			purple = "#b16286",
			aqua = "#689d6a",
			orange = "#d65d0e",
		}

		require("lualine").setup({
			options = {
				theme = {
					normal = {
						a = { fg = colors.yellow, bg = "none", gui = "bold" },
						b = { fg = colors.blue, bg = "none" },
						c = { fg = colors.fg, bg = "none" },
					},
					insert = {
						a = { fg = colors.green, bg = "none", gui = "bold" },
						b = { fg = colors.blue, bg = "none" },
						c = { fg = colors.fg, bg = "none" },
					},
					visual = {
						a = { fg = colors.purple, bg = "none", gui = "bold" },
						b = { fg = colors.blue, bg = "none" },
						c = { fg = colors.fg, bg = "none" },
					},
					replace = {
						a = { fg = colors.red, bg = "none", gui = "bold" },
						b = { fg = colors.blue, bg = "none" },
						c = { fg = colors.fg, bg = "none" },
					},
					command = {
						a = { fg = colors.orange, bg = "none", gui = "bold" },
						b = { fg = colors.blue, bg = "none" },
						c = { fg = colors.fg, bg = "none" },
					},
					inactive = {
						a = { fg = colors.gray, bg = "none" },
						b = { fg = colors.gray, bg = "none" },
						c = { fg = colors.gray, bg = "none" },
					},
				},
				section_separators = "",
				component_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 3 } },
				lualine_x = {},
				lualine_y = { "filetype" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})

		local clear_statusline = function()
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
			vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

			for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
				for _, section in ipairs({ "a", "b", "c", "x", "y", "z" }) do
					local name = "lualine_" .. section .. "_" .. mode
					local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })

					if ok then
						hl.bg = nil
						vim.api.nvim_set_hl(0, name, hl)
					end
				end
			end
		end

		clear_statusline()
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("TransparentLualine", { clear = true }),
			callback = clear_statusline,
		})
	end,
}
