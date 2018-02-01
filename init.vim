call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'Shougo/deoplete.nvim'
Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'idris-hackers/idris-vim'
Plug 'the-lambda-church/coquille'

Plug 'zchee/deoplete-clang'

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

Plug 'dart-lang/dart-vim-plugin'
Plug 'villainy/deoplete-dart', { 'for': 'dart' }

Plug 'eagletmt/neco-ghc'
Plug 'neovimhaskell/haskell-vim'
Plug 'eagletmt/ghcmod-vim'
Plug 'alx741/vim-hindent'
Plug 'itchyny/vim-haskell-indent'

Plug 'FrigoEU/psc-ide-vim'
Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
Plug 'Chiel92/vim-autoformat'

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'rust-lang/rust.vim'

Plug 'landaire/deoplete-d'
Plug 'JesseKPhillips/d.vim'

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

colorscheme dracula
let g:airline_theme='dracula'
set background=dark
hi Comment cterm=italic

let g:deoplete#sources#clang#libclang_path = '/usr/local/Cellar/llvm/5.0.0/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/usr/local/Cellar/llvm/5.0.0/lib/clang'
let g:deoplete#sources#clang#flags = [
      \ "-std=c++17"
      \ ]
let g:ale_cpp_clang_executable = '/usr/local/Cellar/llvm/5.0.0/bin/clang++'
let g:ale_cpp_clang_options = '-std=c++17 -Wall'
let g:ale_cpp_clangcheck_executable = '/usr/local/Cellar/llvm/5.0.0/bin/clang-check'


" colorscheme space-vim-dark
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'


let g:haskell_indent_disable = 1

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

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
\   'cpp': ['clang'],
\   'html': ['htmlhint'],
\   'haskell': ['stack-ghc-mod', 'hlint']
\}


set clipboard=unnamed

nmap <silent> <C-B> :NERDTreeToggle<CR>
nmap <silent> <Leader><Leader> :noh<CR>
nmap <silent> <Leader>gs :Gstatus<CR>
nmap <silent> <Leader>gd :Gdiff<CR>

" Move line up or down
nnoremap <S-j> :m .+1<CR>==
nnoremap <S-k> :m .-2<CR>==

" Haskell specific key bindings
autocmd FileType haskell nmap <silent> <Leader>t :GhcModType<CR>
autocmd FileType haskell nmap <silent> <Leader>d :GhcModSigCodegen<CR>
autocmd FileType haskell nmap <silent> <Leader>c :GhcModSplitFunCase<CR>
autocmd FileType haskell nmap <silent> <Leader><Leader> :noh<CR>:GhcModTypeClear<CR>
" Comment out line in normal mode
autocmd FileType haskell nmap <Leader>cc :s/^\(\s*\)/\1\-- /<CR> :noh <CR>
autocmd FileType haskell nmap <Leader>uc :s/^\(\s*\)--\s*/\1/<CR> :noh <CR>
" Comment out region in visual mode
autocmd FileType haskell vmap <Leader>cc :s/^\(\s*\)/\1-- /g<CR> :noh <CR>
autocmd FileType haskell vmap <Leader>uc :s/^\(\s*\)--\s*/\1/g<CR> :noh <CR>

autocmd FileType haskell set tabstop=2
autocmd FileType haskell set shiftwidth=2

" Typescript and Javascript keybindings
autocmd FileType typescript nmap <silent> <Leader>t :TSType<CR>
autocmd FileType typescript nmap <silent> <Leader>g :TSDef<CR>
autocmd FileType typescript nmap <silent> <Leader>p :TSDefPreview<CR>

" Comment out line in normal mode
autocmd FileType typescript,javascript,rust nmap <Leader>cc :s/^\(\s*\)/\1\/\/ /<CR> :noh <CR>
autocmd FileType typescript,javascript,rust nmap <Leader>uc :s/^\(\s*\)\/\/\s*/\1/<CR> :noh <CR>
" Comment out region in visual mode
autocmd FileType typescript,javascript,rust vmap <Leader>cc :s/^\(\s*\)/\1\/\/ /g<CR> :noh <CR>
autocmd FileType typescript,javascript,rust vmap <Leader>uc :s/^\(\s*\)\/\/\s*/\1/g<CR> :noh <CR>

nmap <silent> <Leader>e :ALENextWrap<CR>

let g:necoghc_use_stack = 0
"set omnifunc=syntaxcomplete#Complete

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

