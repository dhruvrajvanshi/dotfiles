vim.g.mapleader = " "

vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.grepprg = "rg --vimgrep -uu --smart-case --hidden $* ."
vim.keymap.set("n", "<leader>gg", ":copen | :silent :grep ")

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true -- Highlight the line where the cursor is on.
vim.o.scrolloff = 10 -- Keep this many screen lines above/below the cursor.

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s) See `:help 'confirm'`
vim.o.confirm = true

vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		vim.o.clipboard = "unnamedplus"
	end,
})

-- Use <Esc> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })

vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window right" })
vim.keymap.set("n", "grd", ":e %/..<CR>", { desc = "[G]o to [d]irectory" })

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})

if vim.g.vscode then
	return
end

-- https://neovim.io/doc/user/diagnostic.html
vim.diagnostic.config({
	virtual_text = {
		current_line = true,
	},
	float = {
		border = "rounded",
	},
})

require("bootstrap-lazy")
---@diagnostic disable-next-line: missing-fields
require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})

vim.cmd.colorscheme("onedark")
