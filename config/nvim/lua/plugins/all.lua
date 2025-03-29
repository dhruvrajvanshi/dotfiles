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

	{
		"nvim-lualine/lualine.nvim",
		opts = {},
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
					c = {
						require("formatter.filetypes.c").clangformat,
					},
					cpp = {
						require("formatter.filetypes.c").clangformat,
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
	-- automatically save and restore currently opened buffers,
	-- and cursor positions
	{
		"rmagatti/auto-session",
		lazy = false,

		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/projects", "~/Downloads", "/", "~/projects/work" },
		},
	},
}
