call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'crusoexia/vim-monokai'
Plug 'pangloss/vim-javascript'
Plug 'Shougo/deoplete.nvim'
Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'w0rp/ale'
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
call plug#end()

syntax on

colorscheme monokai

" colorscheme space-vim-dark
let g:ale_sign_column_always = 1
let g:airline_theme='oceanicnext'

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

let g:syntastic_js_checkers = ['eslint']

let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
let g:javascript_plugin_jsdoc = 1

let g:deoplete#enable_at_startup = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules|bower_components)$'  
  \ }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set number
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
\   'typescript': ['tsserver', 'tslint'],
\   'html': ['htmlhint']
\}

set clipboard=unnamed
