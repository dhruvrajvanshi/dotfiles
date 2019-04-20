filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set clipboard=unnamed
let &t_Co=256

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'w0rp/ale'

Plug 'tpope/vim-surround'

Plug 'pangloss/vim-javascript'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'HerringtonDarkholme/yats.vim'

Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

Plug 'Chiel92/vim-autoformat'

Plug 'morhetz/gruvbox'

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'rust-lang/rust.vim'


Plug 'liuchengxu/space-vim-dark'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'mhartington/oceanic-next'
Plug 'crusoexia/vim-monokai'
Plug 'altercation/vim-colors-solarized'
Plug 'colepeters/spacemacs-theme.vim'
Plug 'rakr/vim-one'
Plug 'hzchirs/vim-material'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'flazz/vim-colorschemes'
call plug#end()
let g:mapleader = ","

syntax on

colorscheme gruvbox
let g:airline_theme='gruvbox'
set background=dark
hi Comment cterm=italic

let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'



let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
let g:javascript_plugin_jsdoc = 1

let g:deoplete#enable_at_startup = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules|bower_components|_build|coverage)$'
  \ }

set statusline+=%#warningmsg#
set statusline+=%*
set number
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
\   'rust': ['rls', 'cargo'],
\   'typescript': ['tsserver', 'tslint'],
\   'html': ['htmlhint'],
\}



nmap <silent> <C-B> :NERDTreeToggle<CR>
nmap <silent> <Leader><Leader> :noh<CR>
nmap <silent> <Leader>gs :Gstatus<CR>
nmap <silent> <Leader>gd :Gdiff<CR>

" Comment out line in normal mode
autocmd FileType typescript,javascript,rust nmap <Leader>cc :s/^\(\s*\)/\1\/\/ /<CR> :noh <CR>
autocmd FileType typescript,javascript,rust nmap <Leader>uc :s/^\(\s*\)\/\/\s*/\1/<CR> :noh <CR>
" Comment out region in visual mode
autocmd FileType typescript,javascript,rust vmap <Leader>cc :s/^\(\s*\)/\1\/\/ /g<CR> :noh <CR>
autocmd FileType typescript,javascript,rust vmap <Leader>uc :s/^\(\s*\)\/\/\s*/\1/g<CR> :noh <CR>

nmap <silent> <Leader>e :ALENextWrap<CR>

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

augroup vimrc
    autocmd!
augroup END

" Load local vimrc (.vimrc.local) if available
autocmd vimrc VimEnter,BufNewFile,BufReadPost * call s:LoadLocalVimrc()
autocmd vimrc BufWritePre * :call s:StripTrailingWhitespaces()

set scrolloff=8

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'


let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:ale_sign_error = '❗'
let g:ale_sign_warning = '🖕'
highlight clear ALEErrorSign
highlight clear ALEWarningSign

set hidden

function! SomeCheck()
   if filereadable(".vimrc")
       echo ".vimrc exists in local directory"
   endif
endfunction

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['/opt/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ }

function! s:StripTrailingWhitespaces()
    let l:l = line(".")
    let l:c = col(".")
    %s/\s\+$//e
    call cursor(l:l, l:c)
endfunction

function! s:LoadLocalVimrc()
    if filereadable(glob(getcwd() . '/.vimrc.local'))
        :execute 'source '.fnameescape(glob(getcwd(). '/.vimrc.local'))
    endif
endfunction

function! s:ShowType()
    if expand('%:e')
endfunction
