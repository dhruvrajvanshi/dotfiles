-- Function to toggle Fugitive windows
function ToggleFugitive()
	-- Check if any windows have fugitive filetype
	local has_fugitive_window = false

	-- Iterate through all windows
	for _, win in pairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

		if filetype == "fugitive" then
			has_fugitive_window = true
			break
		end
	end

	-- Toggle based on whether fugitive windows exist
	if has_fugitive_window then
		-- Close all fugitive windows
		for _, win in pairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

			if filetype == "fugitive" then
				vim.api.nvim_win_close(win, false)
			end
		end
	else
		-- Open fugitive
		vim.cmd("G")
	end
end

-- Create a command to use the function
vim.api.nvim_create_user_command("ToggleFugitive", ToggleFugitive, {})
vim.api.nvim_set_keymap("n", "<C-S-I>", ":ToggleFugitive<CR>", { noremap = true, silent = true })

---@module "lazy"
---@type LazySpec
return {
	-- Show git changes in the gutter
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{ "tpope/vim-fugitive" },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
		},
		config = true,
	},
}
