vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'morhetz/gruvbox'
  use 'loctvl842/monokai-pro.nvim'
  use 'tpope/vim-commentary'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  use({ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } })

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      { 'williamboman/mason.nvim' }, -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-buffer' }, -- Optional
      { 'hrsh7th/cmp-path' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' }, -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' }, -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use { 'lewis6991/gitsigns.nvim' }
end)

vim.g.mapleader = ' '

vim.cmd.colorscheme('monokai-pro')

vim.wo.number = true
vim.wo.relativenumber = true

vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true

vim.o.scrolloff = 12

vim.opt.termguicolors = true

require("nvim-tree").setup()

local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<C-S-N>', telescope.git_files, {})
vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>')

require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "help" },

  ignore_install = { 'help' },

  auto_install = true,

  highlight = {
    enable = true,
  },
}

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
})

vim.keymap.set('n', 'gh', vim.lsp.buf.hover)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end)

vim.diagnostic.config({ virtual_text = true })

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()
lsp.setup()
