local M = {}
local codelens_enabled = {}

---@param client vim.lsp.Client
---@param method vim.lsp.protocol.Method
---@param bufnr? integer
---@return boolean
local function client_supports_method(client, method, bufnr)
	if vim.fn.has("nvim-0.11") == 1 then
		return client:supports_method(method, bufnr)
	end

	return client.supports_method(method, { bufnr = bufnr })
end

local function setup_document_highlight(event, client)
	if not client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
		return
	end

	local highlight_group = vim.api.nvim_create_augroup("trip-lsp-highlight", { clear = false })
	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		buffer = event.buf,
		group = highlight_group,
		callback = vim.lsp.buf.document_highlight,
	})

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		buffer = event.buf,
		group = highlight_group,
		callback = vim.lsp.buf.clear_references,
	})

	vim.api.nvim_create_autocmd("LspDetach", {
		group = vim.api.nvim_create_augroup("trip-lsp-detach", { clear = true }),
		callback = function(event2)
			vim.lsp.buf.clear_references()
			vim.api.nvim_clear_autocmds({ group = "trip-lsp-highlight", buffer = event2.buf })
		end,
	})
end

local function setup_codelens(event, client)
	if not vim.lsp.codelens then
		return
	end

	if not client_supports_method(client, "textDocument/codeLens", event.buf) then
		return
	end

	codelens_enabled[event.buf] = true

	local codelens_group = vim.api.nvim_create_augroup("trip-lsp-codelens-" .. event.buf, { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
		buffer = event.buf,
		group = codelens_group,
		callback = function()
			if not codelens_enabled[event.buf] then
				return
			end
			vim.lsp.codelens.refresh({ bufnr = event.buf })
		end,
	})

	vim.api.nvim_create_autocmd("LspDetach", {
		group = vim.api.nvim_create_augroup("trip-lsp-codelens-detach-" .. event.buf, { clear = true }),
		buffer = event.buf,
		callback = function()
			codelens_enabled[event.buf] = nil
		end,
	})

	vim.schedule(function()
		if vim.api.nvim_buf_is_valid(event.buf) and codelens_enabled[event.buf] then
			vim.lsp.codelens.refresh({ bufnr = event.buf })
		end
	end)
end

local function setup_inline_completion(event, client, map)
	if not vim.lsp.inline_completion then
		return
	end

	local inline_completion_method = vim.lsp.protocol.Methods.textDocument_inlineCompletion
		or "textDocument/inlineCompletion"
	if not client_supports_method(client, inline_completion_method, event.buf) then
		return
	end

	vim.lsp.inline_completion.enable(true, { bufnr = event.buf, client_id = client.id })

	map("<leader>ui", function()
		local enabled = vim.lsp.inline_completion.is_enabled({ bufnr = event.buf, client_id = client.id })
		vim.lsp.inline_completion.enable(not enabled, { bufnr = event.buf, client_id = client.id })
	end, "Toggle inline completion")
	vim.keymap.set("i", "<M-l>", vim.lsp.inline_completion.get, {
		buffer = event.buf,
		desc = "LSP: Accept inline completion",
	})
	map("<M-]>", function()
		vim.lsp.inline_completion.select({ bufnr = event.buf, count = 1 })
	end, "Next inline completion", "i")
	map("<M-[>", function()
		vim.lsp.inline_completion.select({ bufnr = event.buf, count = -1 })
	end, "Previous inline completion", "i")
end

function M.on_attach(event)
	local map = function(keys, func, desc, mode, opts)
		mode = mode or "n"
		opts = vim.tbl_extend("force", { buffer = event.buf, desc = "LSP: " .. desc }, opts or {})
		vim.keymap.set(mode, keys, func, opts)
	end

	map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
	map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
	map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
	map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
	map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
	map("grx", vim.lsp.codelens.run, "Run code lens")
	map("<leader>uL", function()
		codelens_enabled[event.buf] = not codelens_enabled[event.buf]
		if codelens_enabled[event.buf] then
			vim.lsp.codelens.refresh({ bufnr = event.buf })
		else
			vim.lsp.codelens.clear(nil, event.buf)
		end
	end, "Toggle code [L]ens")
	map("<leader>dQ", vim.lsp.buf.workspace_diagnostics, "Open workspace diagnostics")

	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then
		return
	end

	setup_document_highlight(event, client)
	setup_codelens(event, client)
	setup_inline_completion(event, client, map)
end

return M
