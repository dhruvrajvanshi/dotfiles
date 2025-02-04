
require("mason").setup()
require("mason-lspconfig").setup()

require'lspconfig'.ts_ls.setup {}

require'lspconfig'.rust_analyzer.setup {}

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.supports_method('textDocument/rename') then
        -- Create a keymap for vim.lsp.buf.rename()
        vim.keymap.set('n', '<S-R>', vim.lsp.buf.rename)
	vim.keymap.set('n', '<F2>', vim.lsp.buf.rename)
      end
      if client.supports_method('textDocument/definition') then
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
      end

      if client.supports_method('textDocument/formatting') and client.name ~= 'ts_ls' then
        -- Format the current buffer on save
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format({bufnr = args.buf, id = client.id})
          end,
        })
      end 
    end,
  })
