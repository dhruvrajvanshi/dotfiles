
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'morhetz/gruvbox'
  use 'tpope/vim-commentary'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  use({ 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'} })

end)

vim.g.mapleader = ' '

vim.cmd.colorscheme('gruvbox')

local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<C-N>', telescope.git_files, {})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "help" },

  auto_install = true,

  highlight = {
    enable = true,
  },
}
