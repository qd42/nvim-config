-- Debugging configuration with DAP (Debug Adapter Protocol)
-- This file sets up debugging capabilities for various languages

return {
  -- nvim-dap - Debug Adapter Protocol client
  -- Main debugging plugin that communicates with debug adapters
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",  -- UI for debugging
      "nvim-neotest/nvim-nio", -- Required for nvim-dap-ui
    },
    keys = {
      -- Debug control mappings
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue execution" },
      { "<leader>ds", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },

      -- Breakpoint management
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dB", function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, desc = "Set conditional breakpoint" },
      { "<leader>dm", function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, desc = "Set log point" },

      -- Debug session management
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open debug REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run last debug session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate debug session" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
      { "<leader>dg", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },

      -- Variable inspection
      { "<leader>dv", function() require("dap.ui.variables").scopes() end, desc = "Show variable scopes" },
      { "<leader>dh", function() require("dap.ui.variables").hover() end, desc = "Hover variables" },
      { "<leader>dV", function() require("dap.ui.variables").visual_hover() end, mode = "v", desc = "Visual hover" },
      { "<leader>dW", function() require("dap.ui.widgets").hover() end, desc = "Widget hover" },
      { "<leader>dC", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end, desc = "Centered variable scopes" },
    },
    config = function()
      local dap = require("dap")

      -- C/C++ Debug Adapter Configuration
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.stdpath("data") .. "/dap/extension/debugAdapters/bin/OpenDebugAD7",
        options = {
          detached = false -- Keep attached to Neovim process
        }
      }

      -- Windows-specific C/C++ adapter
      if vim.fn.has("win32") == 1 then
        dap.adapters.cppdbgwin = {
          id = "cppdbg",
          type = "executable",
          command = vim.fn.stdpath("data") .. "\\dap\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe",
          options = {
            detached = false
          }
        }
      end

      -- Helper function to get executable path from user
      local function get_executable_path()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end

      -- C/C++ Debug Configurations
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = get_executable_path,   -- Ask user for executable
          cwd = "${workspaceFolder}",      -- Current workspace directory
          stopOnEntry = true,              -- Stop at main function
        },
        {
          name = "Attach to gdbserver :1234",
          type = "cppdbg",
          request = "launch",
          MIMode = "gdb",                  -- Use GDB as backend
          miDebuggerServerAddress = "localhost:1234", -- GDB server address
          miDebuggerPath = "/usr/bin/gdb", -- Path to GDB
          cwd = "${workspaceFolder}",
          program = get_executable_path,
        },
      }

      -- Add Windows-specific configuration if on Windows
      if vim.fn.has("win32") == 1 then
        table.insert(dap.configurations.cpp, {
          name = "Launch file (Windows)",
          type = "cppdbgwin",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "\\", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
        })
      end

      -- Use same configurations for C and Rust
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      -- Define signs for breakpoints and debug status
      local signs = {
        DapBreakpoint = {
          text = "",
          texthl = "DapBreakpoint",
          linehl = "DapBreakpoint",
          numhl = "DapBreakpoint"
        },
        DapBreakpointCondition = {
          text = "ﳁ",
          texthl = "DapBreakpoint",
          linehl = "DapBreakpoint",
          numhl = "DapBreakpoint"
        },
        DapBreakpointRejected = {
          text = "",
          texthl = "DapBreakpoint",
          linehl = "DapBreakpoint",
          numhl = "DapBreakpoint"
        },
        DapLogPoint = {
          text = "",
          texthl = "DapLogPoint",
          linehl = "DapLogPoint",
          numhl = "DapLogPoint"
        },
        DapStopped = {
          text = "",
          texthl = "DapStopped",
          linehl = "DapStopped",
          numhl = "DapStopped"
        },
      }

      -- Apply the signs
      for name, sign in pairs(signs) do
        vim.fn.sign_define(name, sign)
      end
    end,
  },

  -- nvim-dap-ui - Debug UI
  -- Provides a complete debugging interface with windows for variables, stack, etc.
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup({
        -- Icons for the debug UI
        icons = {
          expanded = "▾",      -- Expanded tree node
          collapsed = "▸",     -- Collapsed tree node
          current_frame = "▸"  -- Current stack frame
        },

        -- Key mappings within debug UI
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" }, -- Expand/collapse
          open = "o",          -- Open item
          remove = "d",        -- Remove item (like breakpoint)
          edit = "e",          -- Edit item
          repl = "r",          -- Open in REPL
          toggle = "t",        -- Toggle item
        },

        -- Expand long lines (requires Neovim 0.7+)
        expand_lines = vim.fn.has("nvim-0.7") == 1,

        -- Layout configuration - defines windows and their positions
        layouts = {
          {
            -- Left sidebar with debugging information
            elements = {
              { id = "scopes", size = 0.25 }, -- Variable scopes (25% of height)
              "breakpoints",                  -- Breakpoint list
              "stacks",                       -- Call stack
              "watches",                      -- Watch expressions
            },
            size = 40,          -- 40 columns wide
            position = "left",  -- Position on left side
          },
          {
            -- Bottom panel with REPL and console
            elements = {
              "repl",    -- Debug REPL
              "console", -- Debug console output
            },
            size = 0.25,         -- 25% of total height
            position = "bottom", -- Position at bottom
          },
        },

        -- Debug controls (requires Neovim nightly or 0.8+)
        controls = {
          enabled = true,
          element = "repl", -- Show controls in REPL window
          icons = {
            pause = "",      -- Pause execution
            play = "",       -- Continue execution
            step_into = "",  -- Step into function
            step_over = "",  -- Step over line
            step_out = "",   -- Step out of function
            step_back = "",  -- Step backwards (if supported)
            run_last = "↻",  -- Run last configuration
            terminate = "□", -- Terminate session
          },
        },

        -- Floating window configuration
        floating = {
          max_height = nil,     -- Use available height
          max_width = nil,      -- Use available width
          border = "single",    -- Border style
          mappings = {
            close = { "q", "<Esc>" }, -- Keys to close floating windows
          },
        },

        -- General window settings
        windows = { indent = 1 }, -- Indentation level

        -- Rendering options
        render = {
          max_type_length = nil,   -- No limit on type name length
          max_value_lines = 100,   -- Max lines for variable values
        }
      })
    end,
  },

  -- Telescope DAP Integration
  -- Adds Telescope pickers for DAP functionality
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("telescope").load_extension("dap") -- Load the DAP extension
    end,
  },

  -- Python DAP Support
  -- Adds Python debugging capabilities
  {
    "mfussenegger/nvim-dap-python",
    ft = "python", -- Load only for Python files
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-python").setup("python") -- Use system Python
    end,
  },

  -- Lua DAP Support
  -- Enables debugging of Neovim Lua scripts
  {
    "jbyuki/one-small-step-for-vimkind",
    ft = "lua", -- Load only for Lua files
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")

      -- Lua debug adapter configuration
      dap.adapters.nlua = function(callback, config)
        callback({
          type = "server",
          host = config.host or "127.0.0.1",
          port = config.port or 8086
        })
      end

      -- Lua debug configuration
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        }
      }
    end,
  },
}
