-- Neovim options and settings configuration
-- This file sets up all the basic Vim options for a modern editing experience

local opt = vim.opt -- Shorthand for vim.opt
local g = vim.g     -- Shorthand for vim.g (global variables)

-- Core Settings
opt.compatible = false -- Disable Vi compatibility mode for full Neovim features

-- UI and Display Settings
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Show relative line numbers for easier navigation
opt.cursorline = true     -- Highlight the current line
opt.showmatch = true      -- Highlight matching brackets when cursor is over them
opt.termguicolors = true  -- Enable 24-bit RGB colors in the terminal
opt.mouse = "a"           -- Enable mouse support in all modes

-- Search Settings
opt.hlsearch = true   -- Highlight search results
opt.incsearch = true  -- Show search matches as you type
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true  -- Override ignorecase if search contains uppercase

-- Indentation and Formatting
opt.tabstop = 4      -- Number of spaces a tab counts for
opt.softtabstop = 4  -- Number of spaces to use for editing operations
opt.shiftwidth = 4   -- Number of spaces for each indentation level
opt.expandtab = true -- Convert tabs to spaces
opt.autoindent = true -- Copy indent from current line when starting new line
opt.smartindent = true -- Smart autoindenting for C-like programs

-- File Handling
opt.swapfile = false -- Disable swap files (we rely on undofile instead)
opt.backup = false   -- Don't create backup files
opt.undofile = true  -- Enable persistent undo across sessions

-- Set platform-specific directories for undo and backup files
if vim.fn.has("win32") == 1 then
  -- Windows paths
  opt.undodir = vim.fn.expand("~/AppData/Local/nvim/undo")
  opt.backupdir = vim.fn.expand("~/AppData/Local/nvim/backup")
else
  -- Unix-like paths (Linux, macOS)
  opt.undodir = vim.fn.expand("~/.cache/nvim/undo")
  opt.backupdir = vim.fn.expand("~/.cache/nvim/backup")
end

-- Utility function to ensure directories exist
local function ensure_dir(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p") -- Create directory and parent directories
  end
end

-- Create necessary directories
ensure_dir(vim.o.undodir)
ensure_dir(vim.o.backupdir)

-- Completion Settings
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.completeopt = "menu,menuone,noselect" -- Completion popup behavior

-- System Integration
opt.clipboard = "unnamedplus" -- Use system clipboard for all operations

-- Performance Settings
opt.ttyfast = true      -- Indicate fast terminal connection
opt.timeout = false     -- Don't timeout on mappings
opt.ttimeout = true     -- Timeout on key codes
opt.ttimeoutlen = 50    -- Time to wait for key code sequence

-- Language and Spell Checking
opt.spelllang = "en_us" -- Set spell check language

-- Enable file type detection and plugins
vim.cmd("filetype plugin indent on") -- Enable filetype detection, plugins, and indent
vim.cmd("syntax on")                 -- Enable syntax highlighting

-- Windows-specific shell configuration
if vim.fn.has("win32") == 1 then
  -- Use PowerShell as the default shell on Windows for better compatibility
  if vim.fn.executable("pwsh") == 1 then
    opt.shell = "pwsh" -- PowerShell Core (preferred)
  elseif vim.fn.executable("powershell") == 1 then
    opt.shell = "powershell" -- Windows PowerShell (fallback)
  end
  
  -- Configure shell command execution for PowerShell
  opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
  opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  opt.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
  opt.shellquote = ""   -- No shell quoting needed for PowerShell
  opt.shellxquote = ""  -- No shell execute quoting needed
end