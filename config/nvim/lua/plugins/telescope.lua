return {
	{
		"nvim-telescope/telescope.nvim",
		-- the latest tagged version is quite old, and it shows
		-- a warning about the missing second argument telescope
		-- vim.lsp.util.make_position_params
		-- This is why I've fixed it to the latest commit
		branch = "master",
		commit = "a4ed82509cecc56df1c7138920a1aeaf246c0ac5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		init = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-S-N>", builtin.git_files, { desc = "Telescope git files" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
			vim.keymap.set("n", "<C-S-F>", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope lsp document symbols" })
		end,
		opts = {
			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = true,
					hidden = true,
				},
				live_grep = {
					theme = "dropdown",
					previewer = true,
				},
				git_files = {
					theme = "dropdown",
					previewer = true,
					show_untracked = true,
				},
				lsp_document_symbols = {
					theme = "dropdown",
					previewer = true,
				},
				lsp_references = {
					theme = "dropdown",
					previewer = true,
				},
				lsp_definitions = {
					theme = "dropdown",
					previewer = true,
				},
			},
		},
	},
	{
		-- Use telescope as the default select UI
		-- This is helpful for a better code actions ui
		"nvim-telescope/telescope-ui-select.nvim",
		opts = {},
		init = function()
			require("telescope").load_extension("ui-select")
		end,
	},
}
