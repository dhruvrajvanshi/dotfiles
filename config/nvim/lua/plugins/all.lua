return {
	{ "morhetz/gruvbox" },
	{ "loctvl842/monokai-pro.nvim" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- Comment a line using gcc, or any object using gc<motion>, e.g. gci{
	{ "tpope/vim-commentary" },
	{ "tpope/vim-surround" },
	-- Repeat action (.) doesn't work with vim-surround. This fixes that
	{ "tpope/vim-repeat" },

	-- Adds :GBrowse command for interacting with github
	{ "tpope/vim-rhubarb" },
	{ "folke/which-key.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
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
			vim.keymap.set("n", "<C-S-F>", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		end,
	},

	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			notifier = {
				-- your notifier configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
		},
	},

	-- Shows the :command line in a floating window
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
		},
		init = function()
			vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
		end,
	},

	-- Show git changes in the gutter
	{
		"lewis6991/gitsigns.nvim",
		init = function()
			require("gitsigns").setup()
		end,
	},
	{ "tpope/vim-fugitive" },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
	},

	{
		"nvim-lualine/lualine.nvim",
		init = function()
			require("lualine").setup({})
		end,
	},
	{ "kyazdani42/nvim-web-devicons" },

	{ "github/copilot.vim" },

	{
		"mhartington/formatter.nvim",
		init = function()
			require("formatter").setup({
				filetype = {
					javascript = {
						require("formatter.filetypes.javascript").prettier,
					},
					javascriptreact = {
						require("formatter.filetypes.javascript").prettier,
					},
					typescript = {
						require("formatter.filetypes.javascript").prettier,
					},
					typescriptreact = {
						require("formatter.filetypes.javascript").prettier,
					},
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					rust = {
						require("formatter.filetypes.rust").rustfmt,
					},
					toml = {
						require("formatter.filetypes.toml").taplo,
					},
				},
			})
			vim.keymap.set("n", "<leader>pp", ":Format<CR>")
			local augroup = vim.api.nvim_create_augroup
			local autocmd = vim.api.nvim_create_autocmd
			augroup("__formatter__", { clear = true })
			autocmd("BufWritePost", {
				group = "__formatter__",
				command = ":FormatWrite",
			})
		end,
	},
	{
		-- Shows error messages from LSP in a floating window
		"dgagn/diagflow.nvim",
		opts = {
			show_borders = true,
		},
	},
}
