
require("mason").setup()
require("mason-lspconfig").setup()

require'lspconfig'.ts_ls.setup {}

require"cmp".setup {
  sources = {
    { name = "nvim_lsp" },
  }
}
