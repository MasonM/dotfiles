set nocompatible
filetype on                     " recognize filetypes
syntax on
filetype plugin indent on
set et
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set ignorecase
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

" Remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

filetype indent on              " Enable filetype-specific indenting

set pastetoggle=<C-P>

let g:vimwiki_url_maxsave = 0
let g:vimwiki_list = [{'path': '~/src/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

let g:pyindent_open_paren = '&sw'
let g:pyindent_continue = '&sw'

let g:ale_linters_explicit = 1
"\   'javascript': ['eslint'],
let g:ale_linters = {
\   'javascript': [],
\   'php': [],
\}

execute pathogen#infect()

" Show nbsp and other ws:https://vi.stackexchange.com/a/17701
set list listchars=tab:»\ ,nbsp:⎵,precedes:<,extends:>

vnoremap <C-J> :!fmt -80<CR>

au BufNewFile,BufRead *.applescript set filetype=applescript
au BufNewFile,BufRead *.js6 set filetype=javascript
au BufNewFile,BufRead *.xt  set filetype=xt
au BufNewFile,BufRead Jenkinsfile*  set filetype=groovy
