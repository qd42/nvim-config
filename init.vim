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
nnoremap <leader>vt :terminal<cr>

nnoremap <M-h> h
nnoremap <M-j> j
nnoremap <M-k> k
nnoremap <M-l> l
nnoremap <M-u> :tabprev<cr>
nnoremap <M-i> :tabnext<cr>

nnoremap <leader>tt :Telescope<cr>
nnoremap <leader>ts :Telescope grep_string<cr>
nnoremap <leader>tg :Telescope live_grep<cr>
nnoremap <leader>tf :Telescope find_files<cr>
nnoremap <leader>tb :Telescope buffers<cr>
nnoremap <leader>to :Telescope oldfiles<cr>
nnoremap <leader>tc :Telescope command_history<cr>
nnoremap <leader>tS :Telescope search_history<cr>
nnoremap <leader>tq :Telescope quickfix<cr>
nnoremap <leader>tr :Telescope registers<cr>
nnoremap <leader>tR :Telescope lsp_references<cr>
nnoremap <leader>tI :Telescope lsp_incoming_calls<cr>
nnoremap <leader>tO :Telescope lsp_outgoing_calls<cr>
nnoremap <leader>tD :Telescope diagnostics<cr>
nnoremap <leader>tT :Telescope lsp_type_definitions<cr>

nnoremap <leader>cc :make<cr>
nnoremap <leader>cj :cnext<cr>
nnoremap <leader>ck :cprev<cr>

nnoremap <M-t> :NvimTreeToggle<cr>
nnoremap <M-b> :bn<cr>
nnoremap <M-c> :bdelete<cr>

lua require('plugins')
