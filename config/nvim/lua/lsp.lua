require("mason").setup()
require("mason-lspconfig").setup()

require("lspconfig").ts_ls.setup({})

require("lspconfig").rust_analyzer.setup({})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.supports_method("textDocument/rename") then
			-- Create a keymap for vim.lsp.buf.rename()
			vim.keymap.set("n", "<S-R>", vim.lsp.buf.rename)
			vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
			vim.keymap.set("n", "grn", vim.lsp.buf.rename)
		end
		if client.supports_method("textDocument/definition") then
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
			vim.keymap.set("n", "gh", vim.lsp.buf.hover)
		end

		if client.supports_method("textDocument/references") then
			vim.keymap.set("n", "grr", vim.lsp.buf.references)
		end

		if client.supports_method("textDocument/implementation") then
			vim.keymap.set("n", "gri", vim.lsp.buf.implementation)
		end
	end,
})
