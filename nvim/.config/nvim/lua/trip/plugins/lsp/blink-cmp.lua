return {
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = (function()
				return "make install_jsregexp"
			end)(),
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
			opts = {},
		},
		"folke/lazydev.nvim",
		"onsails/lspkind.nvim",
	},
	---@module "blink.cmp"
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				treesitter_highlighting = true,
				window = {
					border = "rounded",
				},
			},
			menu = {
				border = "rounded",
				scrollbar = false,
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								local icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = require("lspkind").symbolic(ctx.kind, {
										mode = "symbol",
									})
								end

								return (icon or "") .. ctx.icon_gap
							end,
						},
						kind = {
							highlight = function(ctx)
								local hl = ctx.kind_hl
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local _, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_hl then
										hl = dev_hl
									end
								end
								return hl
							end,
						},
					},
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "lazydev" },
			providers = {
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
			},
		},
		snippets = { preset = "luasnip" },
		fuzzy = { implementation = "lua" },
		signature = {
			enabled = true,
			window = {
				border = "rounded",
			},
		},
	},
	config = function(_, opts)
		require("blink.cmp").setup(opts)

		local group = vim.api.nvim_create_augroup("trip-blink-cmp-cleanup", { clear = true })
		local close_blink = function()
			pcall(function()
				require("blink.cmp.completion.trigger").hide()
			end)
			pcall(function()
				require("blink.cmp.signature.trigger").hide()
			end)
		end

		vim.api.nvim_create_autocmd({ "InsertLeavePre", "CmdlineLeave", "ModeChanged" }, {
			group = group,
			callback = function()
				local mode = vim.api.nvim_get_mode().mode
				if mode:match("^[isR]") or mode == "c" then
					return
				end
				close_blink()
			end,
		})
	end,
}
