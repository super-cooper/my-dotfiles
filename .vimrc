" Enable pathogen
execute pathogen#infect()

" Enable Vundle
set rtp+=~/.vim/bundle/Vundle.vim

" Enable syntax highlighting with 'material' theme
syntax on
let g:one_allow_italics=1
set background=dark
colo one
if (has("termguicolors"))
  set termguicolors
endif

" Indent
filetype plugin indent on

" Enable line numbers
set number

" Autoload file changes
set autoread

" Search before pressing enter
set incsearch

" Replace tabs with 4 spaces
set tabstop=4 shiftwidth=4 expandtab

""""""""""""Vundle plugins""""""""""""""
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" WakaTime plugin
Plugin 'wakatime/vim-wakatime'

call vundle#end()

" Use system clipboard for copy/paste
if has('macunix')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

"""""""""""Airline settings"""""""""""""
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif
let g:airline_symbols.space="\ua0"
let g:airline_theme='one'
set fillchars+=stl:\ ,stlnc:\
