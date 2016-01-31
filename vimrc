set nocompatible
filetype on                     " recognize filetypes
syntax on
filetype plugin indent on
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set smartcase
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set autoindent
set nohls                       " do not highlight the last used search pattern
set incsearch                   " do incremental searching
set background=dark
set textwidth=100
set wildmenu
filetype indent on              " Enable filetype-specific indenting
set pastetoggle=<C-P>
let g:syntastic_puppet_checkers=['puppetlint']
let g:syntastic_puppet_puppetlint_args='--no-80chars-check'
let g:pyindent_open_paren = '&sw'
let g:pyindent_continue = '&sw'
execute pathogen#infect()
"source /home/mrmalone/php-doc.vim
"inoremap <C-L> <ESC>:call PhpDocSingle()<CR>i
"nnoremap <C-L> :call PhpDocSingle()<CR>
"vnoremap <C-L> :call PhpDocRange()<CR>
vnoremap <C-J> :!fmt -80<CR>
"source /usr/share/vim/vim70/syntax/php.vim
"source /usr/share/vim/vim70/indent/php.vim
au BufNewFile,BufRead *.applescript set filetype=applescript
