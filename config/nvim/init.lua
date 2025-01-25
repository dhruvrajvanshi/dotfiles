-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Colorschemes
  { "morhetz/gruvbox" },
  { "loctvl842/monokai-pro.nvim" },

  -- Provides syntax highlighting for various languages; Set to auto install when a buffer
  -- is opened
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Comment a line using gcc, or any object using gc<motion>, e.g. gci{
  { "tpope/vim-commentary" },

  -- Provides fuzzy search; Set to C-Shift-N
  { "junegunn/fzf", build = ":call fzf#install()" },
  { "junegunn/fzf.vim" },

  -- Show git changes in the gutter
  { "airblade/vim-gitgutter" },
  { "tpope/vim-fugitive" },
  { "beauwilliams/statusline.lua" },

  { "github/copilot.vim" },

  { "williamboman/mason.nvim" },
})

vim.diagnostic.config({
  virtual_text = false
})

vim.g.mapleader = ' '

vim.cmd.colorscheme('monokai-pro')

vim.wo.number = true
vim.wo.relativenumber = true

vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true

vim.o.scrolloff = 12

vim.opt.termguicolors = true

vim.keymap.set('n', '<leader>ff', ':Files<CR>', {})
vim.keymap.set('n', '<C-S-N>', ':GFiles<CR>', {})
vim.keymap.set('n', '<C-S-F>', ':Rg<CR>')

require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "help" },

  ignore_install = { 'help' },

  auto_install = true,

  highlight = {
    enable = true,
  },
}

-- https://neovim.io/doc/user/diagnostic.html
vim.diagnostic.config({ virtual_text = true })


