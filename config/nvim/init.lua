vim.g.mapleader = " "
require("bootstrap-lazy")

---@diagnostic disable-next-line: missing-fields
require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})

vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 12
vim.opt.termguicolors = true
vim.opt.swapfile = false

vim.cmd.colorscheme("ayu-mirage")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {})
vim.keymap.set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })

vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window right" })

-- https://neovim.io/doc/user/diagnostic.html
vim.diagnostic.config({
	virtual_text = {
		current_line = true,
	},
	float = {
		border = "rounded",
	},
})
