-- Language Server Protocol (LSP) configuration
-- This file sets up LSP servers for intelligent code features

return {
  -- Mason LSP Server Manager
  -- Automatically installs and manages LSP servers
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- Update registry on installation
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded", -- Rounded borders for Mason UI
        },
      })
    end,
  },

  -- LSP Configuration
  -- Main LSP configuration plugin
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- Load when opening files
    dependencies = {
      "williamboman/mason.nvim",  -- LSP server management
      "hrsh7th/cmp-nvim-lsp",     -- LSP completion source
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Enhanced LSP capabilities with nvim-cmp
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- LSP keymaps function - applied when LSP attaches to buffer
      local on_attach = function(client, bufnr)
        local keymap = require("utils.keymap")
        local map = keymap.map

        local opts = { buffer = bufnr } -- Buffer-local mappings

        -- Navigation mappings
        map("n", "<leader>ld", vim.lsp.buf.declaration, "Go to declaration", opts)
        map("n", "<leader>lD", vim.lsp.buf.definition, "Go to definition", opts)
        map("n", "<leader>lh", vim.lsp.buf.hover, "Show hover information", opts)
        map("n", "<leader>li", vim.lsp.buf.implementation, "Go to implementation", opts)
        map("n", "<leader>lH", vim.lsp.buf.signature_help, "Show signature help", opts)

        -- Workspace management
        map("n", "<leader>l+", vim.lsp.buf.add_workspace_folder, "Add workspace folder", opts)
        map("n", "<leader>l-", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder", opts)
        map("n", "<leader>l?", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "List workspace folders", opts)

        -- Code actions and refactoring
        map("n", "<leader>lt", vim.lsp.buf.type_definition, "Go to type definition", opts)
        map("n", "<leader>lr", vim.lsp.buf.rename, "Rename symbol", opts)
        map("n", "<leader>la", vim.lsp.buf.code_action, "Show code actions", opts)
        map("n", "<leader>lR", vim.lsp.buf.references, "Show references", opts)

        -- Diagnostics
        map("n", "<leader>ls", vim.diagnostic.open_float, "Show line diagnostics", opts)
        map("n", "<leader>lj", vim.diagnostic.goto_next, "Next diagnostic", opts)
        map("n", "<leader>lk", vim.diagnostic.goto_prev, "Previous diagnostic", opts)

        -- Formatting
        map("n", "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, "Format document", opts)

        -- Clangd-specific mappings
        if client.name == "clangd" then
          map("n", "<leader>lc", "<cmd>ClangdSwitchSourceHeader<cr>", "Switch source/header", opts)
        end
      end

      -- LSP server configurations
      local servers = {
        -- Clangd for C/C++
        clangd = {
          cmd = {
            "clangd",
            "--background-index",        -- Index in background
            "--clang-tidy",             -- Enable clang-tidy
            "--header-insertion=iwyu"   -- Include what you use
          },
        },

        -- Lua Language Server
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" }, -- Tell server we're using LuaJIT
              diagnostics = {
                globals = { "vim" }             -- Recognize 'vim' global
              },
              workspace = {
                checkThirdParty = false,        -- Don't ask about third party
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                },
              },
            },
          },
        },

        -- Rust Analyzer
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true, -- Enable all Cargo features
              },
            },
          },
        },

        -- GLSL Language Server (for shader files)
        glslls = {},
      }

      -- Setup each LSP server with common configuration
      for server_name, config in pairs(servers) do
        config.capabilities = capabilities -- Add completion capabilities
        config.on_attach = on_attach       -- Add keymaps when LSP attaches
        lspconfig[server_name].setup(config)
      end

      -- Global diagnostic configuration
      vim.diagnostic.config({
        virtual_text = true,      -- Show diagnostics as virtual text
        signs = true,             -- Show diagnostic signs in gutter
        underline = true,         -- Underline diagnostic text
        update_in_insert = false, -- Don't update diagnostics in insert mode
        severity_sort = true,     -- Sort diagnostics by severity
        float = {
          border = "rounded",     -- Rounded borders for diagnostic floats
          source = "always",      -- Always show diagnostic source
        },
      })

      -- Define diagnostic signs for the gutter
      local signs = {
        Error = " ", -- Error icon
        Warn  = " ", -- Warning icon
        Hint  = " ", -- Hint icon
        Info  = " ", -- Info icon
      }

      -- Apply diagnostic signs
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },

  -- LSP Saga - Enhanced LSP UI
  -- Provides better LSP interfaces and floating windows
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach", -- Load when LSP attaches
    keys = {
      -- Enhanced LSP operations with better UI
      { "<leader>sf", "<cmd>Lspsaga finder<cr>", desc = "LSP Finder" },
      { "<leader>sa", "<cmd>Lspsaga code_action<cr>", desc = "Code action" },
      { "<leader>sr", "<cmd>Lspsaga rename<cr>", desc = "Rename symbol" },
      { "<leader>sp", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" },
      { "<leader>sd", "<cmd>Lspsaga goto_definition<cr>", desc = "Go to definition" },

      -- Enhanced diagnostics
      { "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line diagnostics" },
      { "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", desc = "Cursor diagnostics" },
      { "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc = "Buffer diagnostics" },
      { "<leader>sj", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next diagnostic" },
      { "<leader>sk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Previous diagnostic" },

      -- Code navigation
      { "<leader>so", "<cmd>Lspsaga outline<cr>", desc = "Symbol outline" },
      { "<leader>sI", "<cmd>Lspsaga incoming_calls<cr>", desc = "Incoming calls" },
      { "<leader>sO", "<cmd>Lspsaga outgoing_calls<cr>", desc = "Outgoing calls" },
    },
    config = function()
      require("lspsaga").setup({
        ui = {
          theme = "round",      -- Rounded theme
          border = "rounded",   -- Rounded borders
          winblend = 0,         -- No transparency
          expand = "",          -- Expand icon
          collapse = "",        -- Collapse icon
          preview = " ",        -- Preview icon
          code_action = "💡",   -- Code action icon
          diagnostic = "🐞",    -- Diagnostic icon
          incoming = " ",       -- Incoming calls icon
          outgoing = " ",       -- Outgoing calls icon
          colors = {
            -- Custom color scheme for LSP Saga
            normal_bg = "#1d1536",
            title_bg = "#afd700",
            red = "#e95678",
            magenta = "#b33076",
            orange = "#FF8700",
            yellow = "#f7bb3b",
            green = "#afd700",
            cyan = "#36d0e0",
            blue = "#61afef",
            purple = "#CBA6F7",
            white = "#d1d4cf",
            black = "#1c1c19",
          },
        },
      })
    end,
  },

  -- LSP Signature Help
  -- Shows function signatures while typing
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy", -- Load after other plugins
    config = function()
      require("lsp_signature").setup({
        bind = false,                              -- Don't bind keys automatically
        handler_opts = {
          border = "rounded"                       -- Rounded border
        },
        floating_window = true,                    -- Use floating window
        floating_window_above_cur_line = true,     -- Position above cursor
        hint_enable = true,                        -- Enable virtual text hints
        hint_prefix = "🐼 ",                       -- Cute panda prefix
        hint_scheme = "String",                    -- Color scheme for hints
        hi_parameter = "LspSignatureActiveParameter", -- Highlight active parameter
        max_height = 12,                           -- Maximum window height
        max_width = 80,                            -- Maximum window width
        close_timeout = 4000,                      -- Auto-close timeout
        doc_lines = 10,                            -- Number of doc lines to show
      })
    end,
  },

  -- LSP Lines - Better Diagnostic Display
  -- Shows diagnostics using virtual lines instead of virtual text
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_lines").setup()
      -- Disable default virtual text since lsp_lines replaces it
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  },

  -- LSP Kind Icons
  -- Provides icons for LSP completion items
  {
    "onsails/lspkind-nvim",
    lazy = true, -- Load when needed
    config = function()
      require("lspkind").init({
        mode = "symbol_text",  -- Show both symbol and text
        preset = "codicons",   -- Use VS Code icons
        symbol_map = {
          -- Custom symbol mappings for different completion types
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "ﰠ",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "塞",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "פּ",
          Event = "",
          Operator = "",
          TypeParameter = ""
        },
      })
    end,
  },
}
