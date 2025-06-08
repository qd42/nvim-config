-- Additional tools and utilities
-- This file contains miscellaneous plugins that don't fit in other categories

return {
  -- Markdown Preview
  -- Live preview of markdown files in browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      -- Only build if npm is available
      if vim.fn.executable("npm") == 1 then
        return "cd app && npm install"
      else
        vim.notify("npm not found. Markdown preview may not work properly.", vim.log.levels.WARN)
      end
    end,
    ft = { "markdown" }, -- Load only for markdown files
    keys = {
      { "<leader>vm", "<cmd>MarkdownPreview<cr>", desc = "Start markdown preview" },
    },
    config = function()
      -- Plugin configuration
      vim.g.mkdp_filetypes = { "markdown" }     -- Supported filetypes
      vim.g.mkdp_open_to_the_world = 1          -- Allow external access
      vim.g.mkdp_preview_options = {
        uml = {
          -- Custom PlantUML server (replace with your own if needed)
          server = "https://pricing-plantuml.cluster-one.test.dtc.iggroup.local"
        },
      }
    end,
  },

  -- Claude.vim - AI Assistant Integration
  -- Integrates Claude AI assistant into Neovim
  {
    "pasky/claude.vim",
    cmd = { "Claude", "ClaudeImplement", "ClaudeChat" }, -- Load on command
    keys = {
      { "<leader>ai", "<cmd>ClaudeImplement<cr>", desc = "Claude implement code" },
      { "<leader>ac", "<cmd>ClaudeChat<cr>", desc = "Open Claude chat" },
      { "<C-a>", "<cmd>ClaudeSendChatMessage<cr>", desc = "Send chat message" },
      { "<leader>ax", "<cmd>ClaudeCancelResponse<cr>", desc = "Cancel Claude response" },
    },
    config = function()
      -- Configuration is typically done in local.lua to keep API keys private
      -- Example: vim.g.claude_api_key = "your-api-key-here"
    end,
  },
  {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({})
      end,
  },
  {
      "zbirenbaum/copilot-cmp",
      config = function()
          require("copilot_cmp").setup()
      end,
  },
  -- ChatGPT Integration
  -- Alternative AI assistant integration
  {
    "jackMort/ChatGPT.nvim",
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTCompleteCode",
      "ChatGPTRun",
      "ChatGPTEditWithInstructions"
    },
    dependencies = {
      "MunifTanjim/nui.nvim",         -- UI components
      "nvim-lua/plenary.nvim",        -- Utility functions
      "nvim-telescope/telescope.nvim"  -- Fuzzy finder integration
    },
    config = function()
      require("chatgpt").setup() -- Use default configuration
      -- API key should be set in environment variable OPENAI_API_KEY
    end,
  },

  -- Ripgrep
  -- Fast text search tool (used by other plugins)
  {
    "BurntSushi/ripgrep",
    lazy = true, -- Only load when needed by other plugins
  },
}
