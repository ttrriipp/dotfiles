vim.opt.guicursor = "" -- fat cursor
vim.opt.colorcolumn = "80" -- idk

-- tab options
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- command line options
vim.o.laststatus = 3
vim.o.cmdheight = 1

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- enable mouse
vim.o.mouse = "a"

vim.o.showmode = false -- hide the modes text
vim.o.breakindent = true -- indent

vim.o.undofile = true -- persistent undo

vim.o.ignorecase = true -- case insensitive search
vim.o.smartcase = true -- smart case sensitive

vim.o.signcolumn = "yes" -- sign column

vim.o.updatetime = 250

vim.o.timeoutlen = 300

-- splits
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.inccommand = "split"

vim.o.cursorline = false

vim.o.scrolloff = 8

vim.o.confirm = true
vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"
vim.opt.swapfile = false

-- clipboard
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
