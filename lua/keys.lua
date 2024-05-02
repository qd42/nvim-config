vim.g.mapleader = " "

local silent_noremap = {silent = true, noremap = true}
local silent_noremap_expr = {silent = true, noremap = true, expr = true}

-- I used SPACE as a leader key so killing default action here
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>',silent_noremap)
-- that's an easy way to leave terminal mode
vim.api.nvim_set_keymap('t', '<Esc><Space>', '<C-\\><C-N>',silent_noremap)

-- 'various' mappings
vim.api.nvim_set_keymap('n','<leader>vs', '<cmd>source $MYVIMRC<cr> ',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>ve','<cmd>edit $MYVIMRC<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>vt','<cmd>ToggleTerm<cr>',silent_noremap)

-- Alt - hjkl to switch windows
vim.api.nvim_set_keymap('n','<M-h>','h',silent_noremap)
vim.api.nvim_set_keymap('n','<M-j>','j',silent_noremap)
vim.api.nvim_set_keymap('n','<M-k>','k',silent_noremap)
vim.api.nvim_set_keymap('n','<M-l>','l',silent_noremap)
-- not sure I want to keep these:
vim.api.nvim_set_keymap('n','<M-u>','<cmd>tabprev<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<M-i>','<cmd>tabnext<cr>',silent_noremap)

-- Telescope:
vim.api.nvim_set_keymap('n','<leader>tt','<cmd>Telescope<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>ts','<cmd>Telescope grep_string<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tg','<cmd>Telescope live_grep<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tf','<cmd>Telescope find_files<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tb','<cmd>Telescope buffers<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>to','<cmd>Telescope oldfiles<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tc','<cmd>Telescope command_history<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tS','<cmd>Telescope search_history<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tq','<cmd>Telescope quickfix<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tr','<cmd>Telescope registers<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tR','<cmd>Telescope lsp_references<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tI','<cmd>Telescope lsp_incoming_calls<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tO','<cmd>Telescope lsp_outgoing_calls<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tD','<cmd>Telescope diagnostics<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>tT','<cmd>Telescope lsp_type_definitions<cr>',silent_noremap)
vim.api.nvim_set_keymap('n','<leader>ta','<cmd>Telescope resume<cr>',silent_noremap)

vim.api.nvim_set_keymap('n', '<leader>cc','<cmd>make<cr>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>cj','<cmd>cnext<cr>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>ck','<cmd>cprev<cr>',silent_noremap)

vim.api.nvim_set_keymap('n', '<M-t>','<cmd>NvimTreeToggle<cr>',silent_noremap)
vim.api.nvim_set_keymap('n', '<M-b>','<cmd>bn<cr>',silent_noremap)
vim.api.nvim_set_keymap('n', '<M-c>','<cmd>bdelete<cr>',silent_noremap)

-- DAP:
vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>ds', '<cmd>lua require"dap".step_over()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>di', '<cmd>lua require"dap".step_into()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua require"dap".step_out()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>dv', '<cmd>lua require"dap.ui.variables".scopes()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>dh', '<cmd>lua require"dap.ui.variables".hover()<CR>',silent_noremap)
vim.api.nvim_set_keymap('v', '<leader>dV', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>dW', '<cmd>lua require"dap.ui.widgets".hover()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>dC', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>dB', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>dm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua require"dap".repl.open()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua require"dap".run_last()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>dt', '<cmd>lua require"dap".terminate()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>du', '<cmd>lua require"dapui".toggle()<CR>',{})

-- GIT:
vim.api.nvim_set_keymap('n', '<leader>gj', '<cmd>lua require"gitsigns".next_hunk()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>gk', '<cmd>lua require"gitsigns".prev_hunk()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>lua require"gitsigns".diffthis()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>gs', '<cmd>lua require"gitsigns".show()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>lua require"gitsigns".blame_line()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>gr', '<cmd>lua require"gitsigns".reset_hunk()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>gh', '<cmd>lua require"gitsigns".preview_hunk()<CR>',silent_noremap) -- I am thinking 'hoover' hence 'h' not 'p' like lsp
vim.api.nvim_set_keymap('n', '<leader>gD', '<cmd>lua require"gitsigns".toggle_deleted()<CR>',silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>gS', '<cmd>lua require"gitsigns".toggle_signs()<CR>',silent_noremap)

-- LUA snip:
vim.api.nvim_set_keymap('i', '<Tab>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", silent_noremap_expr)
vim.api.nvim_set_keymap('i', '<S-Tab>', "<cmd>lua require'luasnip'.jump(-1)<Cr>",silent_noremap)
vim.api.nvim_set_keymap('s', '<Tab>', "<cmd>lua require'luasnip'.jump(1)<Cr>",silent_noremap)
vim.api.nvim_set_keymap('s', '<S-Tab>', "<cmd>lua require'luasnip'.jump(-1)<Cr>",silent_noremap)
vim.api.nvim_set_keymap('i', '<C-E>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", silent_noremap_expr)
vim.api.nvim_set_keymap('s', '<C-E>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", silent_noremap_expr)

vim.api.nvim_set_keymap('n', "<leader>sf", '<cmd>Lspsaga lsp_finder<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>sa", '<cmd>Lspsaga code_action<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>sr", '<cmd>Lspsaga rename<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>sp", '<cmd>Lspsaga peek_definition<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>sd", '<cmd>Lspsaga goto_definition<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>sl", '<cmd>Lspsaga show_line_diagnostics<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>sc", '<cmd>Lspsaga show_cursor_diagnostics<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>sb", '<cmd>Lspsaga show_buf_diagnostics<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>sj", '<cmd>Lspsaga diagnostic_jump_next<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>sk", '<cmd>Lspsaga diagnostic_jump_prev<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>so", '<cmd>Lspsaga outline<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>sI", '<cmd>Lspsaga incoming_calls<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', "<leader>sO", '<cmd>Lspsaga outgoing_calls<CR>', silent_noremap)

vim.api.nvim_set_keymap('n', '<leader>sf', '<cmd>Lspsaga lsp_finder<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>sa', '<cmd>Lspsaga code_action<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>sr', '<cmd>Lspsaga rename<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>sp', '<cmd>Lspsaga peek_definition<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>sd', '<cmd>Lspsaga goto_definition<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>sl', '<cmd>Lspsaga show_line_diagnostics<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>sc', '<cmd>Lspsaga show_cursor_diagnostics<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>sb', '<cmd>Lspsaga show_buf_diagnostics<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>sj', '<cmd>Lspsaga diagnostic_jump_next<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>sk', '<cmd>Lspsaga diagnostic_jump_prev<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>so', '<cmd>Lspsaga outline<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>sI', '<cmd>Lspsaga incoming_calls<CR>', silent_noremap_expr)
vim.api.nvim_set_keymap('n', '<leader>sO', '<cmd>Lspsaga outgoing_calls<CR>', silent_noremap_expr)

vim.api.nvim_set_keymap('n', '<leader>vm', '<cmd>MarkdownPreview<CR>', silent_noremap)
vim.api.nvim_set_keymap('n', '<leader>vf', "<cmd>ClangFormat<CR>", silent_noremap)
