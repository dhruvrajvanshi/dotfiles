vim.g.mapleader = " "
require("bootstrap-lazy")
require("lazy").setup("plugins")

vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.o.scrolloff = 12
vim.opt.termguicolors = true

vim.diagnostic.config({
	virtual_text = false,
})

vim.cmd.colorscheme("catppuccin-frappe")
vim.keymap.set("n", "<leader>ff", ":Files<CR>", {})
vim.keymap.set("n", "<C-S-N>", ":GFiles<CR>", {})
vim.keymap.set("n", "<C-S-F>", ":Rg<CR>")

-- https://neovim.io/doc/user/diagnostic.html
vim.diagnostic.config({
	-- Show the diagnostic message on the line where the error is
	-- Without this, the diagnostic will be underlined, but there's
	-- no obvious way to read the message
	virtual_text = false,
})

require("lsp")
