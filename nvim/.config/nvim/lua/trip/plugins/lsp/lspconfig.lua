return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("trip-lsp-attach", { clear = true }),
			callback = require("trip.lsp.keymaps").on_attach,
		})

		require("trip.lsp.diagnostics").setup()

		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local servers = require("trip.lsp.servers").get()
		local ensure_installed = vim.tbl_keys(servers)

		vim.list_extend(ensure_installed, { "stylua" })
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_enable = true,
		})

		for server_name, server in pairs(servers) do
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			vim.lsp.config(server_name, server)
			vim.lsp.enable(server_name)
		end
	end,
}
