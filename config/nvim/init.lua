vim.g.mapleader = " "
require("bootstrap-lazy")
require("lazy").setup("plugins")

vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 12
vim.opt.termguicolors = true
vim.opt.swapfile = false

vim.diagnostic.config({
	virtual_text = false,
})

vim.cmd.colorscheme("catppuccin-frappe")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {})
vim.keymap.set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })

vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window right" })

-- https://neovim.io/doc/user/diagnostic.html
vim.diagnostic.config({
	-- Show the diagnostic message on the line where the error is
	-- Without this, the diagnostic will be underlined, but there's
	-- no obvious way to read the message
	virtual_text = false,
})
