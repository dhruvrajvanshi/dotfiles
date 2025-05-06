-- Floating Terminal Toggle Function for Neovim
-- This function creates or toggles a floating terminal window

-- Global variable to store terminal buffer and window information
local floating_term = {
	buf = nil,
	win = nil,
	term_chan = nil,
}

-- Function to toggle the floating terminal
function _G.toggle_floating_term()
	-- If terminal window exists and is visible, hide it
	if floating_term.win and vim.api.nvim_win_is_valid(floating_term.win) then
		vim.api.nvim_win_hide(floating_term.win)
		floating_term.win = nil
		return
	end

	-- Get editor dimensions
	local width = vim.o.columns
	local height = vim.o.lines

	-- Calculate floating window size (80% of editor size)
	local win_width = math.floor(width * 0.8)
	local win_height = math.floor(height * 0.8)

	-- Calculate starting position to center the window
	local row = math.floor((height - win_height) / 2)
	local col = math.floor((width - win_width) / 2)

	-- Window options
	local win_opts = {
		relative = "editor",
		row = row,
		col = col,
		width = win_width,
		height = win_height,
		style = "minimal",
		border = "rounded",
	}

	-- Create or reuse terminal buffer
	if not floating_term.buf or not vim.api.nvim_buf_is_valid(floating_term.buf) then
		-- Create a new buffer
		floating_term.buf = vim.api.nvim_create_buf(false, true)

		-- Set buffer options
		vim.api.nvim_set_option_value("bufhidden", "hide", { buf = floating_term.buf })
		vim.api.nvim_set_option_value("filetype", "terminal", { buf = floating_term.buf })

		-- Create the window first so the terminal opens in it
		floating_term.win = vim.api.nvim_open_win(floating_term.buf, true, win_opts)

		-- Set window options
		vim.api.nvim_set_option_value("winblend", 10, { win = floating_term.win })
		vim.api.nvim_set_option_value("winhl", "Normal:Normal", { win = floating_term.win })

		-- Now create the terminal in the buffer
		floating_term.term_chan = vim.fn.termopen(vim.o.shell, {
			on_exit = function()
				-- Clean up when terminal exits
				if floating_term.win and vim.api.nvim_win_is_valid(floating_term.win) then
					vim.api.nvim_win_close(floating_term.win, true)
				end
				floating_term.buf = nil
				floating_term.win = nil
				floating_term.term_chan = nil
			end,
		})

		-- Start in insert mode
		vim.cmd("startinsert")
	else
		-- Create new window with the existing buffer
		floating_term.win = vim.api.nvim_open_win(floating_term.buf, true, win_opts)

		-- Set window options
		vim.api.nvim_set_option_value("winblend", 10, { win = floating_term.win })
		vim.api.nvim_set_option_value("winhl", "Normal:Normal", { win = floating_term.win })

		-- Start in insert mode
		vim.cmd("startinsert")
	end
end

-- Example keybinding (add to your init.lua or equivalent):
vim.api.nvim_set_keymap("n", "<leader>ft", ":lua toggle_floating_term()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-S-M>", "<C-\\><C-n>:lua toggle_floating_term()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-M>", ":lua toggle_floating_term()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"t",
	"<Esc><Esc>",
	"<C-\\><C-n>:lua toggle_floating_term()<CR>",
	{ noremap = true, silent = true }
)

---@module "lazy"
---@type LazySpec
return {}
