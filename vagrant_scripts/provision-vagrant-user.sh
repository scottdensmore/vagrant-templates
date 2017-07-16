#!/bin/bash
set -e

# This script runs as the 'vagrant' user

if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -f ~/.ssh/id_rsa -q -N ""
fi

cat << EOF > ~/.vimrc
" Most of this config was lifted from http://jsdelfino.blogspot.com/2010/11/my-vi-configuration-file.html

" vi-improved mode
set nocompatible

" cycle buffers without writing
set hidden

" backup while writing
set writebackup

" file completion
set wildmenu
set wildmode=list:longest

" update window title
set title

" display cursor location
set ruler
set number

" display current command
set showcmd

" short message prompts
set shortmess=atI

" silent
set noerrorbells

" switch to current file's directory
set autochdir

" remember marks, registers, searches, buffer list
set viminfo='20,<50,s10,h,%

" keep a big history
set history=1000

" syntax highligting
syntax on

" auto smart code indent
set autoindent
filetype indent on
set smartindent
set smarttab
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set shiftround

" allow backspacing in insert mode
set backspace=indent,eol,start

" incremental search
set incsearch
set nohlsearch

" ignore case
set ignorecase
set smartcase

EOF
