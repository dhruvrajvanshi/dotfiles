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
			vim.keymap.set("n", "<C-S-N>", function()
				require("telescope").extensions.smart_open.smart_open({
					cwd_only = true,
					algorithm = "fzy",
				})
			end, { desc = "Go to file" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
			vim.keymap.set("n", "<C-S-F>", function()
				builtin.live_grep({
					layout_strategy = "horizontal",
					path_display = { "truncate" },
					layout_config = {
						horizontal = {
							prompt_position = "top",
							width = { padding = 5 },
							preview_width = 0.5,
						},
					},
				})
			end, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope lsp document symbols" })
		end,
		opts = {
			defaults = {
				dynamic_preview_title = true,
			},
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
	{
		"danielfalk/smart-open.nvim",
		branch = "0.2.x",
		config = function()
			require("telescope").load_extension("smart_open")
		end,
		dependencies = {
			"kkharji/sqlite.lua",
			-- Only required if using match_algorithm fzf
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- Optional.  If installed, native fzy will be used when match_algorithm is fzy
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
	},
}
