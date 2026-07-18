local function format_diagnostic_entry(diagnostic)
	local source = diagnostic.source and ("[%s] "):format(diagnostic.source) or ""
	return ("%s%s"):format(source, diagnostic.message:gsub("%s+", " "))
end

-- paste without losing original copied text
vim.keymap.set("x", "<leader>p", [["_dP]])

-- delete without losing original copied text
vim.keymap.set("v", "<leader>d", [["_d]])

-- yank to system clipboard
-- vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
-- vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })

-- goated navigations
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- quickfix list navigation
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- move lines with shift j/k
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- clear hightlight in search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>dq", function()
	vim.diagnostic.setloclist({
		open = true,
		title = "Buffer Diagnostics",
		format = format_diagnostic_entry,
	})
end, { desc = "Open buffer diagnostics list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>ud", function()
	if vim.diagnostic.is_enabled() then
		vim.diagnostic.enable(false)
	else
		vim.diagnostic.enable(true)
	end
end, { desc = "Toggle diagnostics" })
