local M = {}

function M.get()
	return {
		eslint = {
			settings = {
				workingDirectory = { mode = "auto" },
			},
		},
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		},
		vtsls = {},
		intelephense = {},
		stimulus_ls = {},
		tailwindcss = {},
		cssmodules_ls = {},
	}
end

return M
