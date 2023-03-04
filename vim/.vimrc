"PLUGINS ----------------------------- {{{
call plug#begin('~/.vim/plugged')
  " Color Scheme 
  Plug 'morhetz/gruvbox'
  Plug 'overcache/NeoSolarized'
  " git support
  Plug 'airblade/vim-gitgutter'
  " IDE Like stuff
  Plug 'tpope/vim-commentary' " Comments (gc, gcc)
  Plug 'tpope/vim-surround'
  Plug 'windwp/nvim-ts-autotag'
  Plug 'windwp/nvim-autopairs'
  " Language Support
  " Markdown
  Plug 'plasticboy/vim-markdown'
" }}}

"KEY MAPPINGS ------------------------ {{{
let mapleader = ' ' " SPACE

nnoremap <CR> o<Esc>
" }}}



" AUTOCOMPLETION ----------------------- {{{
filetype plugin on
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" }}}

"CONFIG ------------------------ {{{
" Theme
set termguicolors
set background=dark
colorscheme gruvbox
highlight Normal ctermbg=NONE guibg=NONE
highlight ColorColumn ctermbg=88 guibg=#757575

" Status Line

" Emmet (not sure if works with vim)
let g:user_emmet_install_global = 0                                  
autocmd FileType html,css EmmetInstall

" Disable compatibility with vi
set nocompatible
" Enable type file detection
filetype on
" Enable plugins and load plugins for detected file type
filetype plugin on
" Load an indent file for the detected file type
filetype indent on
" usability
syntax on
set number
set relativenumber
set numberwidth=1
set signcolumn=yes
" Tab Settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab " Space Chars statt Tabs
set smartindent
" Highlight cursor
set nocursorline
set nocursorcolumn
" Don't let cursor scroll below or above N lines
set scrolloff=8
" Soft Wrap
set wrap
set linebreak
set nolist
" Color Line 
set colorcolumn=80
" Show partial command during typing in the last line of the screen
set showcmd
" Show the mode
set showmode
" Show matching words during search
set showmatch
" Highlight during a search
set hlsearch
" While searching though a file incrementally highlight matching charachters during typing
set incsearch
" default history size is 20
set history=1000
" Enable auto completion menu after pressing TAB
set wildmenu
set wildmode=list:longest " bash simiilar autocomplition behaviour
" wildmenu ignore files
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx  
" Don't save backup fiels
set nobackup
set noswapfile

" set shell=/usr/bin/zsh
set shellcmdflag=-ic
" undo settings
set undodir =~/.vim/undodir
" Spell check
set encoding=UTF-8
set spell
set spelllang=en_us,de_de
" Disable Sound on error
set noerrorbells
set noscrollbind
set nocursorbind
set updatetime=50
set foldlevel=99
" }}}


"VIMSCRIPT------------------------ {{{
" Enable code folding
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup filetype_vim

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
" augroup cursor_off
"     autocmd!
"     autocmd WinLeave * set nocursorline nocursorcolumn
"     autocmd WinEnter * set cursorline cursorcolumn
" augroup END
" }}}

