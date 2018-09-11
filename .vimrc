" Enable pathogen
execute pathogen#infect()

" Enable Vundle
set rtp+=~/.vim/bundle/Vundle.vim

" Enable syntax highlighting
syntax on

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
