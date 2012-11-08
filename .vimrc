" turn off some unpleasant vi-compatible behavior, must be first due to its side effects
set nocompatible

filetype off " required for vundle

" setup vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let vundle manage vundle
Bundle 'gmarik/vundle'

" vim-scripts github repos
Bundle 'rails.vim'
Bundle 'vimwiki'
Bundle 'LustyExplorer'
Bundle 'VimClojure'

" other github repos
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-markdown'
Bundle 'othree/html5.vim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'samsonw/vim-task'
Bundle 'kchmck/vim-coffee-script'
Bundle 'scrooloose/syntastic'
Bundle 'hail2u/vim-css3-syntax'

filetype plugin indent on " enable file type detection & file type plugins, load indent file for specific file types

set encoding=utf-8 " use UTF-8 as encoding

set scrolloff=3 " minimal number of screen lines to keep above and below the cursor

set wildmenu " enhanced mode for command-line completion

set smartindent " smart autoindenting when starting a new line
set autoindent  " should be enabled when using smartindent

set number " show line numbers

set hidden " required for LustyExplorer, hides abandoned buffers

set wrap      " wrap long lines
set linebreak " smarter wrapping of long lines

set expandtab     " auto expand tabs to spaces
set tabstop=2     " a tab is two spaces
set shiftwidth=2  " number of spaces to use when indenting
set softtabstop=2 " number of spaces that a tab counts for while performing editing operations

set ignorecase " ignore case when searching
set infercase  " adjust case of match depending on the typed text when doing keyword completion in insert mode
set smartcase  " ignore case if search pattern is lowercase, case-sensitive otherwise
set hlsearch   " highlight search terms
set incsearch  " show search matches as you type

set history=100 " remember the last 100 commands

syntax on " enable syntax highlighting

" change leader key to , (comma)
let mapleader=","

" F2 to switch to paste mode, disabling all kinds of smartness
set pastetoggle=<F2>

" <leader><space> to un-highlight search matches
nnoremap <silent> <leader><space> :noh<cr>

" more natural navigation for wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" <leader>-d to toggle tasks
noremap <silent> <buffer> <leader>d :call Toggle_task_status()<CR>

" compile .scss files when saving them
autocmd BufWritePost,FileWritePost *.scss :silent !compass compile --quiet

" use 4 spaces for PHP files
autocmd FileType php setlocal shiftwidth=4 softtabstop=4 tabstop=4

" rainbow colored parens for Clojure code
let g:vimclojure#ParenRainbow=1
