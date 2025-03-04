return {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		"neovim/nvim-lspconfig",
		init = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({})
			lspconfig.eslint.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.rust_analyzer.setup({})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client == nil then
						return
					end
					if client:supports_method("textDocument/rename") then
						-- Create a keymap for vim.lsp.buf.rename()
						vim.keymap.set("n", "<S-R>", vim.lsp.buf.rename, {
							desc = "LSP Rename",
						})
						vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, {
							desc = "LSP Rename",
						})
						vim.keymap.set("n", "grn", vim.lsp.buf.rename, {
							desc = "LSP Rename",
						})
					end
					if client:supports_method("textDocument/definition") then
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
							desc = "LSP go to definition",
						})
						vim.keymap.set("n", "ght", vim.lsp.buf.hover, {
							desc = "LSP hover",
						})
						vim.keymap.set("n", "ghe", vim.diagnostic.open_float, {
							desc = "LSP error hover",
						})
					end

					if client:supports_method("textDocument/references") then
						vim.keymap.set("n", "grr", vim.lsp.buf.references, {
							desc = "LSP go to references",
						})
					end

					if client:supports_method("textDocument/implementation") then
						vim.keymap.set("n", "gri", vim.lsp.buf.implementation, {
							desc = "LSP go to implementation",
						})
					end
				end,
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	"hrsh7th/cmp-nvim-lsp",
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
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
}
