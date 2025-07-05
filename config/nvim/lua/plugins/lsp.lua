---@module "lazy"
---@type LazySpec
return {
	{
		"dhruvrajvanshi/mason.nvim",
		-- Fork of `williamboman/mason.nvim` with a fix
		-- for early initialization of cached_features
		commit = "aba96ec52f615479c7dd2fc074e4cb66bacaf0bd",
	},
	"williamboman/mason-lspconfig.nvim",
	{
		"neovim/nvim-lspconfig",
		init = function()
			require("mason").setup()
			-- require("mason-lspconfig").setup()
			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({})
			lspconfig.eslint.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.jsonls.setup({})
			if lspconfig.clangd then
				lspconfig.clangd.setup({})
			end
			if lspconfig.biome then
				lspconfig.biome.setup({})
			end
			lspconfig.rust_analyzer.setup({})

			local telescope = require("telescope.builtin")
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
						vim.keymap.set("n", "gd", telescope.lsp_definitions, {
							desc = "[G]o to [D]efinition",
						})
						vim.keymap.set("n", "ght", function()
							vim.lsp.buf.hover({
								border = "rounded",
							})
						end, {
							desc = "LSP hover",
						})
						vim.keymap.set("n", "ghe", vim.diagnostic.open_float, {
							desc = "LSP error hover",
						})
					end

					if client:supports_method("textDocument/references") then
						vim.keymap.set("n", "grr", telescope.lsp_references, {
							desc = "[G]o to [R]eferences",
						})
					end

					if client:supports_method("textDocument/implementation") then
						vim.keymap.set("n", "gri", telescope.lsp_implementations, {
							desc = "[G]o to [I]mplementation",
						})
					end

					vim.keymap.set("n", "gca", vim.lsp.buf.code_action, {
						desc = "[G]o to [C]ode Actions",
					})

					vim.keymap.set("n", "grs", telescope.lsp_document_symbols, {})
				end,
			})
			--- @type table<string, fun()>
			local lsp_commands = {
				rename = vim.lsp.buf.rename,
				references = telescope.lsp_references,
				code_actions = vim.lsp.buf.code_action,
				actions = vim.lsp.buf.code_action,
				definition = telescope.lsp_definitions,
				declaration = vim.lsp.buf.declaration,
				implementation = vim.lsp.buf.implementation,
				hover = vim.lsp.buf.hover,
				signature_help = vim.lsp.buf.signature_help,
				format = vim.lsp.buf.format,
				type_definition = vim.lsp.buf.type_definition,
				workspace_symbols = telescope.lsp_workspace_symbols,
				document_symbols = telescope.lsp_document_symbols,
			}
			vim.api.nvim_create_user_command("Lsp", function(opts)
				local args = opts.args
				local subcommand = vim.split(args, " ")[1]

				if lsp_commands[subcommand] then
					lsp_commands[subcommand]()
				else
					vim.notify("Unknown LSP command: " .. subcommand)
				end
			end, {
				nargs = "+",
				complete = function(ArgLead)
					local matches = {}
					for cmd, _ in pairs(lsp_commands) do
						if cmd:match("^" .. ArgLead) then
							table.insert(matches, cmd)
						end
					end
					return matches
				end,
				desc = "LSP commands",
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
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),

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
