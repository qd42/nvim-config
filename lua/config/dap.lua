local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '~/.local/share/nvim/dap/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require('telescope').load_extension('dap')
-- require('dbg.python')

vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>ds', '<cmd>lua require"dap".step_over()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>di', '<cmd>lua require"dap".step_into()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua require"dap".step_out()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>dv', '<cmd>lua require"dap.ui.variables".scopes()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>dh', '<cmd>lua require"dap.ui.variables".hover()<CR>',{})
vim.api.nvim_set_keymap('v', '<leader>dV', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>dW', '<cmd>lua require"dap.ui.widgets".hover()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>dC', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",{})
vim.api.nvim_set_keymap('n', '<leader>dB', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>dm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua require"dap".repl.open()<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua require"dap".repl.run_last()<CR>',{})

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

vim.api.nvim_set_keymap('n', '<leader>du', '<cmd>lua require"dapui".toggle()<CR>',{})

