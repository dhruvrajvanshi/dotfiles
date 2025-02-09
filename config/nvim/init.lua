require("bootstrap-lazy")

require("lazy").setup({
	-- Colorschemes
	{ "morhetz/gruvbox" },
	{ "loctvl842/monokai-pro.nvim" },

	-- Provides syntax highlighting for various languages; Set to auto install when a buffer
	-- is opened
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- Comment a line using gcc, or any object using gc<motion>, e.g. gci{
	{ "tpope/vim-commentary" },
	{ "tpope/vim-surround" },
	-- Repeat action (.) doesn't work with vim-surround. This fixes that
	{ "tpope/vim-repeat" },

	-- Adds :GBrowse command for interacting with github
	{ "tpope/vim-rhubarb" },

	-- Provides fuzzy search; Set to C-Shift-N
	{ "junegunn/fzf", build = ":call fzf#install()" },
	{ "junegunn/fzf.vim" },

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
	{ "airblade/vim-gitgutter" },
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
	{ "nvim-treesitter/nvim-treesitter-textobjects" },

	{ "beauwilliams/statusline.lua" },

	{ "github/copilot.vim" },

	{ "mhartington/formatter.nvim" },
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"dgagn/diagflow.nvim",
		{
			"saghen/blink.cmp",
			-- optional: provides snippets for the snippet source
			dependencies = "rafamadriz/friendly-snippets",

			-- use a release tag to download pre-built binaries
			version = "*",
			-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
			-- build = 'cargo build --release',
			-- If you use nix, you can build from source using latest nightly rust with:
			-- build = 'nix run .#build-plugin',

			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {
				-- 'default' for mappings similar to built-in completion
				-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
				-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
				-- See the full "keymap" documentation for information on defining your own keymap.
				keymap = { preset = "enter" },

				appearance = {
					-- Sets the fallback highlight groups to nvim-cmp's highlight groups
					-- Useful for when your theme doesn't support blink.cmp
					-- Will be removed in a future release
					use_nvim_cmp_as_default = true,
					-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = "mono",
				},

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
					-- disabling this in the command line because
					-- when keymap is set to enter, :q<Enter> will automatically pick the
					-- first completion item
					cmdline = {},
				},
			},
			opts_extend = { "sources.default" },
		},
	},
})

vim.opt.shiftwidth = 2

vim.diagnostic.config({
	virtual_text = false,
})

vim.g.mapleader = " "

vim.cmd.colorscheme("monokai-pro")

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
require("formatter").setup({
	filetype = {
		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
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
require("diagflow").setup()
