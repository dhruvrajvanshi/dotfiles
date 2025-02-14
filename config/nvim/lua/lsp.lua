require("mason").setup()
require("mason-lspconfig").setup()

require("lspconfig").ts_ls.setup({})
require("lspconfig").eslint.setup({})

require("lspconfig").rust_analyzer.setup({})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.supports_method("textDocument/rename") then
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
		if client.supports_method("textDocument/definition") then
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
				desc = "LSP go to definition",
			})
			vim.keymap.set("n", "gh", vim.lsp.buf.hover, {
				desc = "LSP hover",
			})
			vim.keymap.set("n", "geh", vim.diagnostic.open_float, {
				desc = "LSP error hover",
			})
		end

		if client.supports_method("textDocument/references") then
			vim.keymap.set("n", "grr", vim.lsp.buf.references, {
				desc = "LSP go to references",
			})
		end

		if client.supports_method("textDocument/implementation") then
			vim.keymap.set("n", "gri", vim.lsp.buf.implementation, {
				desc = "LSP go to implementation",
			})
		end
	end,
})
