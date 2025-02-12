require("bootstrap-lazy")

require("lazy").setup({
	-- Colorschemes
	{ "morhetz/gruvbox" },
	{ "loctvl842/monokai-pro.nvim" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	-- Provides syntax highlighting for various languages; Set to auto install when a buffer
	-- is opened
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },

	-- Comment a line using gcc, or any object using gc<motion>, e.g. gci{
	{ "tpope/vim-commentary" },
	{ "tpope/vim-surround" },
	-- Repeat action (.) doesn't work with vim-surround. This fixes that
	{ "tpope/vim-repeat" },

	-- Adds :GBrowse command for interacting with github
	{ "tpope/vim-rhubarb" },
	{ "folke/which-key.nvim" },

	-- Provides fuzzy search; Set to C-Shift-N
	{ "junegunn/fzf", build = ":call fzf#install()" },
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
			require("lualine").setup()
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
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		{
			"hrsh7th/nvim-cmp",
			init = function()
				local cmp = require("cmp")
				cmp.setup({
					snippet = {
						expand = function(args)
							vim.snippet.expand(args.body)
						end,
					},
					mapping = {
						["<Down>"] = cmp.mapping.select_next_item(),
						["<Up>"] = cmp.mapping.select_prev_item(),

						["<CR>"] = cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						}),
					},
					sources = {
						{ name = "nvim_lsp" },
					},
				})
			end,
		},
	},
})

vim.opt.shiftwidth = 2

vim.diagnostic.config({
	virtual_text = false,
})

vim.g.mapleader = " "

vim.cmd.colorscheme("catppuccin-frappe")

vim.wo.number = true
vim.wo.relativenumber = true

vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true

vim.o.scrolloff = 12

vim.opt.termguicolors = true

vim.keymap.set("n", "<leader>ff", ":Files<CR>", {})
vim.keymap.set("n", "<C-S-N>", ":GFiles<CR>", {})
vim.keymap.set("n", "<C-S-F>", ":Rg<CR>")

require("nvim-treesitter.configs").setup({
	auto_install = true,

	highlight = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				-- You can optionally set descriptions to the mappings (used in the desc parameter of
				-- nvim_buf_set_keymap) which plugins like which-key display
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				-- You can also use captures from other query groups like `locals.scm`
				["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = "@function.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
			},
		},
	},
})

-- https://neovim.io/doc/user/diagnostic.html
vim.diagnostic.config({
	-- Show the diagnostic message on the line where the error is
	-- Without this, the diagnostic will be underlined, but there's
	-- no obvious way to read the message
	virtual_text = false,
})

require("lsp")
