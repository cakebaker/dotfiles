" turn off some unpleasant vi-compatible behavior, must be first due to its side effects
set nocompatible

filetype off " required for vundle

" setup vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let vundle manage vundle
Plugin 'gmarik/Vundle.vim'

" vim-scripts github repos
Plugin 'vimwiki'

" other github repos
Plugin 'tpope/vim-markdown'
Plugin 'othree/html5.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'scrooloose/syntastic'
Plugin 'hail2u/vim-css3-syntax'

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

" enable support for function names starting with a keyword
autocmd FileType scss set iskeyword+=-

" use 4 spaces for PHP files
autocmd FileType php setlocal shiftwidth=4 softtabstop=4 tabstop=4

" enable syntax highlighting for ruby snippets in html files
autocmd BufRead,BufNewFile *.html set filetype=eruby

" rainbow colored parens for Clojure code
let g:vimclojure#ParenRainbow=1

" add WhatSyntax command for debugging syntax files
if has("user_commands")
  command -nargs=0 -bar WhatSyntax echomsg synIDattr(synID(line("."),col("."),0),"name") synIDattr(synIDtrans(synID(line("."),col("."),0)),"name") synIDattr(synID(line("."),col("."),1),"name") synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") 
endif
