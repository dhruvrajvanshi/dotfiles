---@module "lazy"
---@type LazySpec
return {
	{ "jiangmiao/auto-pairs" },
	-- Comment a line using gcc, or any object using gc<motion>, e.g. gci{
	{ "tpope/vim-commentary" },
	{ "tpope/vim-surround" },
	-- Repeat action (.) doesn't work with vim-surround. This fixes that
	{ "tpope/vim-repeat" },

	-- Adds :GBrowse command for interacting with github
	{ "tpope/vim-rhubarb" },
	{ "folke/which-key.nvim" },
	{ "morhetz/gruvbox" },
	{
		"navarasu/onedark.nvim",

		config = function()
			require("onedark").setup({
				style = "darker",
			})
		end,
	},
	{ "loctvl842/monokai-pro.nvim" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "Shatur/neovim-ayu" },

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
	{
		"nvim-lualine/lualine.nvim",
		opts = {},
	},
	{ "kyazdani42/nvim-web-devicons" },

	{ "github/copilot.vim" },
	{
		-- Shows breadcrumbs in the top of the window
		-- I installed this because I was having a hard
		-- time seeing which file I'm in.
		-- Had to run :ls % to see the file name
		"Bekaboo/dropbar.nvim",
		config = function()
			vim.cmd([[
        set mousemoveevent
      ]])
		end,
	},
	{
		-- a better looking UI for vim.notify, which is used
		-- by many plugins.
		--
		-- History is available via :Telescope notify
		"rcarriga/nvim-notify",
		---@module "notify"
		---@type notify.Config
		opts = {
			merge_duplicates = false,
		},
		init = function()
			vim.notify = require("notify")
		end,
	},
	{
		-- Better quickfix window
		"https://github.com/stevearc/quicker.nvim",
		ft = "qf",
		init = function() end,
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {
			edit = {
				-- allow editing the quickfix list like a buffer
				enabled = true,
				autosave = true,
			},
			keys = {
				{ ">", "<cmd>lua require('quicker').toggle_expand()<CR>", desc = "Expand quickfix content" },
				{ "<", "<cmd>lua require('quicker').toggle_expand()<CR>", desc = "Collapse quickfix content" },
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		init = function()
			vim.api.nvim_set_keymap(
				"n",
				"<C-S-B>",
				"<cmd>Neotree toggle<CR>",
				{ noremap = true, desc = "Toggle file explorer" }
			)
			vim.api.nvim_set_keymap(
				"i",
				"<C-S-B>",
				"<cmd>Neotree toggle<CR>",
				{ noremap = true, desc = "Toggle file explorer" }
			)
		end,
	},
}
