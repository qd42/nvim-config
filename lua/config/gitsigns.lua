require('gitsigns').setup {
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
vim.api.nvim_set_keymap('n', '<leader>gj', '<cmd>lua require"gitsigns".next_hunk()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>gk', '<cmd>lua require"gitsigns".prev_hunk()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>lua require"gitsigns".diffthis()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>gs', '<cmd>lua require"gitsigns".show()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>lua require"gitsigns".blame_line()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>gr', '<cmd>lua require"gitsigns".reset_hunk()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>gh', '<cmd>lua require"gitsigns".preview_hunk()<CR>',{}) -- I am thinking 'hoover' hence 'h' not 'p' like lsp
vim.api.nvim_set_keymap('n', '<leader>gD', '<cmd>lua require"gitsigns".toggle_deleted()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>gS', '<cmd>lua require"gitsigns".toggle_signs()<CR>',{})

