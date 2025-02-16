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

	-- Provides fuzzy search; Set to C-Shift-N
	{
		"junegunn/fzf",
		build = ":call fzf#install()",
		init = function()
			vim.keymap.set("n", "<leader>ff", ":Files<CR>", {})
			vim.keymap.set("n", "<C-S-N>", ":GFiles<CR>", {})
		end,
	},
	{ "junegunn/fzf.vim" },

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
