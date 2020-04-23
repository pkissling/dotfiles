set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Vundle
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'airblade/vim-gitgutter'
call vundle#end()

filetype plugin indent on    " required

" Rust
let g:rustfmt_autosave = 1 " format upon save

" Enable line numbers
set number

" Enable syntax highlighting
syntax enable

" Allow paste from clipboard
set paste
