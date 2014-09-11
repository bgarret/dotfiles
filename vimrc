
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

execute pathogen#infect()

set laststatus=2
let g:Powerline_symbols = 'fancy'
set t_Co=256

" write utf-8 without a BOM
set nobomb

" Ctrl-P config
cnoreabbrev e CtrlP
cnoreabbrev b CtrlPBuffer
set wildignore+=vendor/ruby/**,vendor,cov,docs,tmp,*/web/assets/*,*/app/cache/*

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number		" show line numbers

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
let ruby_fold=1

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '|': '|'}

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

map <NL> O<Esc>
map <CR> o<Esc>

if has('gui_running')
  set guioptions-=m " remove the menu bar
  set guioptions-=T " remove the tool bar
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a

  " disable the mouse wheel, automatic pasting drives me crazy
  map <MiddleMouse> <Nop>
  imap <MiddleMouse> <Nop>
  map <2-MiddleMouse> <Nop>
  imap <2-MiddleMouse> <Nop>
  map <3-MiddleMouse> <Nop>
  imap <3-MiddleMouse> <Nop>
  map <4-MiddleMouse> <Nop>
  imap <4-MiddleMouse> <Nop>
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  set ts=2 sts=2 sw=2 et

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  autocmd FileType ruby setlocal ai sw=2 sts=2 et

  autocmd FileType python setlocal ai sw=2 sts=2 et
  autocmd FileType javascript setlocal ai sw=4 sts=4 et
  autocmd FileType c setlocal ai ts=8 sw=8 sts=8 noet
  autocmd FileType php setlocal ai ts=4 sw=4 sts=4 et
  autocmd FileType yaml setlocal ai ts=2 sw=2 sts=2 et
  autocmd FileType scss setlocal ai ts=4 sw=4 sts=4 et
  autocmd FileType go setlocal ai ts=4 sw=4 sts=4 noet
  autocmd FileType go autocmd BufWritePre <buffer> Fmt

  " Makefiles need hard tabs
  autocmd FileType make setlocal ai ts=8 sw=8 sts=8 noet

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

let g:solarized_termcolors=16
set background=dark
colorscheme solarized
