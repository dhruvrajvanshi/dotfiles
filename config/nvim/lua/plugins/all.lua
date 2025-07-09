---@module "lazy"
---@type LazySpec
return {
	{ "morhetz/gruvbox" },
	{ "loctvl842/monokai-pro.nvim" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "Shatur/neovim-ayu" },
	-- Comment a line using gcc, or any object using gc<motion>, e.g. gci{
	{ "tpope/vim-commentary" },
	{ "tpope/vim-surround" },
	-- Repeat action (.) doesn't work with vim-surround. This fixes that
	{ "tpope/vim-repeat" },

	-- Adds :GBrowse command for interacting with github
	{ "tpope/vim-rhubarb" },
	{ "folke/which-key.nvim" },

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
			local dropbar_api = require("dropbar.api")

			-- Comes from the suggested config in the readme
			-- Seems useful on a first try
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })

			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })

			-- required for mouse based functionality
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
}
