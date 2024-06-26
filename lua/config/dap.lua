local default_program_linux = vim.fn.getcwd() .. '/'
local default_program_win = vim.fn.getcwd() .. '\\'
local default_args = ''

local dap = require('dap')
dap.adapters.cppdbg = {
      id = 'cppdbg',
        type = 'executable',
          command = vim.fn.stdpath('data') ..'/dap/extension/debugAdapters/bin/OpenDebugAD7',
            options = {
                    detached = false
                      }
                  }
dap.adapters.cppdbgwin = {
      id = 'cppdbg',
        type = 'executable',
          command = vim.fn.stdpath('data') ..'\\dap\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
            options = {
                    detached = false
                      }
                  }
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      default_program_linux = vim.fn.input('Path to executable: ', default_program_linux, 'file')
      return default_program_linux
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
  {
    name = "Launch file (gcc Win)",
    type = "cppdbgwin",
    request = "launch",
    program = function()
      default_program_win = vim.fn.input('Path to executable: ', default_program_win, 'file')
      return default_program_win
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
  {
    name = "Launch file (gcc Win)",
    type = "cppdbgwin",
    request = "launch",
    program = function()
      default_program_win = vim.fn.input('Path to executable: ', default_program_win, 'file')
      return default_program_win
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
      default_program_linux = vim.fn.input('Path to executable: ', default_program_linux, 'file')
      return default_program_linux
    end,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require('telescope').load_extension('dap')
-- require('dbg.python')

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
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
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
