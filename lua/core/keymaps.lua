-- Key mappings configuration
-- This file defines all custom key bindings for enhanced workflow

-- Import keymap utility functions
local keymap = require("utils.keymap")
local map = keymap.map

-- Leader Key Configuration
vim.g.mapleader = " " -- Set space as the leader key
vim.g.maplocalleader = " " -- Set space as the local leader key

-- Disable default space behavior in normal mode
map("n", "<Space>", "<Nop>")

-- Terminal Navigation
-- Easy escape from terminal mode using Esc+Space
map("t", "<Esc><Space>", "<C-\\><C-N>", "Exit terminal mode")

-- Configuration Management
map("n", "<leader>vs", "<cmd>source $MYVIMRC<cr>", "Source config")
map("n", "<leader>ve", "<cmd>edit $MYVIMRC<cr>", "Edit config")

-- Window Navigation (Alt + hjkl)
-- These mappings allow quick movement between split windows
map("n", "<M-h>", "<C-w>h", "Move to left window")
map("n", "<M-j>", "<C-w>j", "Move to bottom window")
map("n", "<M-k>", "<C-w>k", "Move to top window")
map("n", "<M-l>", "<C-w>l", "Move to right window")

-- Tab Navigation
map("n", "<M-u>", "<cmd>tabprev<cr>", "Previous tab")
map("n", "<M-i>", "<cmd>tabnext<cr>", "Next tab")

-- Buffer Navigation
map("n", "<M-b>", "<cmd>bnext<cr>", "Next buffer")
map("n", "<M-c>", "<cmd>bdelete<cr>", "Delete buffer")

-- Build and Compilation
map("n", "<leader>cc", "<cmd>make<cr>", "Make/Build project")
map("n", "<leader>cj", "<cmd>cnext<cr>", "Next quickfix item")
map("n", "<leader>ck", "<cmd>cprev<cr>", "Previous quickfix item")

-- Plugin-specific Mappings
map("n", "<leader>vt", "<cmd>ToggleTerm<cr>", "Toggle terminal")
map("n", "<M-t>", "<cmd>NvimTreeToggle<cr>", "Toggle file tree")
map("n", "<leader>vm", "<cmd>MarkdownPreview<cr>", "Markdown preview")
map("n", "<leader>vf", "<cmd>ClangFormat<cr>", "Format code")

map("n", "<leader>lv", '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>')
