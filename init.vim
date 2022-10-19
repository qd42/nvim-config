set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.
"
"
set notimeout
set ttimeout
let mapleader = " "
nnoremap <Space> <NOP>
tnoremap <Esc><Space> <C-\><C-N>

" call submode#enter_with('window','n','','<leader>w','')
call submode#map('window','n','','h','<C-w>h')
nnoremap <leader>vs :source $MYVIMRC<cr> 
nnoremap <leader>ve :edit $MYVIMRC<cr>

nnoremap <M-h> h
nnoremap <M-j> j
nnoremap <M-k> k
nnoremap <M-l> l

nnoremap <leader>t :Telescope<cr>
nnoremap <M-t> :NvimTreeToggle<cr>
nnoremap <M-b> :bn<cr>
nnoremap <M-c> :bdelete<cr>

lua require('plugins')
" lua require('telescope')
" lua require('cmp')
" lua require('lsp')
" lua require('dap')
" lua require('colorscheme')
