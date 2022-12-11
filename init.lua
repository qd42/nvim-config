
vim.opt.compatible = false -- disable compatibility to old-time vi
vim.opt.showmatch = true      -- show matching
vim.opt.ignorecase = true     -- case insensitive
vim.opt.mouse = "a"          -- middle-click paste with, a - enable mounse
vim.opt.hlsearch = true       -- highlight search
vim.opt.incsearch = true      -- incremental search
vim.opt.tabstop = 4           -- number of columns occupied by
vim.opt.softtabstop = 4       -- see multiple spaces as tabstop
vim.opt.expandtab = true      -- converts tabs to white space
vim.opt.shiftwidth = 4        -- width for autoindents
vim.opt.autoindent = true     -- indent a new line the same amo
vim.opt.number = true         -- add line numbers
vim.opt.relativenumber = true
vim.opt.wildmode = "longest,list" -- get bash-like tab completions st"
vim.opt.clipboard = "unnamedplus" -- using system clipboard (via "+)
vim.opt.filetype.plugin = true
vim.opt.cursorline = true -- highlight current cursorline, not working from LUA????
vim.opt.ttyfast = true -- Speed up scrolling in Vim
vim.opt.timeout = false -- no timeout on leader keys
vim.opt.ttimeout = true -- terminal timeout
vim.opt.swapfile = false
vim.o.termguicolors = true

-- not sure how to do these directly from LUA:
vim.cmd('filetype plugin indent on') -- allow auto-indenting depending on file type
vim.cmd('syntax on') -- syntax highlighting
vim.cmd('filetype plugin on')
vim.cmd('set backupdir=~/.cache/vim')
vim.cmd('set cursorline')

require('plugins')
require('keys')
