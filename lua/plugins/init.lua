-- Plugin configuration entry point
-- This file defines the plugin specification and configures lazy.nvim

-- Define all plugins by importing from separate modules
-- This modular approach keeps plugin configurations organized
local plugins = {
  { "folke/lazy.nvim" }, -- Include lazy.nvim itself

  -- Import plugin groups from separate files
  { import = "plugins.ui" },         -- UI and appearance plugins
  { import = "plugins.editor" },     -- Editor enhancement plugins
  { import = "plugins.lsp" },        -- Language Server Protocol plugins
  { import = "plugins.completion" }, -- Completion and snippets
  { import = "plugins.debugging" },  -- Debugging tools
  { import = "plugins.git" },        -- Git integration
  { import = "plugins.tools" },      -- Additional tools and utilities
}

-- Setup lazy.nvim with the plugin specifications
require("lazy").setup(plugins, {
  defaults = {
    lazy = false,    -- Load plugins immediately by default
    version = false, -- Don't use version constraints by default
  },
  checker = {
    enabled = true,  -- Enable automatic plugin update checking
    notify = false,  -- Don't notify about available updates
  },
  change_detection = {
    notify = false, -- Don't notify when config files change
  },
  performance = {
    rtp = {
      -- Disable built-in plugins that we don't need for better performance
      disabled_plugins = {
        "gzip",        -- Gzip file handling
        "matchit",     -- Extended % matching
        "matchparen",  -- Matching parentheses highlighting
        "netrwPlugin", -- Built-in file explorer
        "tarPlugin",   -- Tar file handling
        "tohtml",      -- Convert to HTML functionality
        "tutor",       -- Vim tutor
        "zipPlugin",   -- Zip file handling
      },
    },
  },
})