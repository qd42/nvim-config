-- Keymap utility functions
-- This module provides consistent keymap creation with better defaults

local M = {} -- Module table

-- Default options for all keymaps
local default_opts = {
  noremap = true, -- Don't allow recursive mappings
  silent = true,  -- Don't show command in command line
}

-- Create a keymap with optional description and custom options
-- @param mode: string - The mode for the mapping (n, i, v, etc.)
-- @param lhs: string - The key combination to map
-- @param rhs: string|function - The command or function to execute
-- @param desc: string|nil - Description for which-key and documentation
-- @param opts: table|nil - Additional options to merge with defaults
function M.map(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  if desc then
    opts.desc = desc -- Add description for which-key plugin
  end
  -- Merge custom options with defaults
  opts = vim.tbl_extend("force", default_opts, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Convenience function for normal mode mappings
-- @param lhs: string - The key combination to map
-- @param rhs: string|function - The command or function to execute
-- @param desc: string|nil - Description for the mapping
-- @param opts: table|nil - Additional options
function M.nmap(lhs, rhs, desc, opts)
  M.map("n", lhs, rhs, desc, opts)
end

-- Convenience function for insert mode mappings
-- @param lhs: string - The key combination to map
-- @param rhs: string|function - The command or function to execute
-- @param desc: string|nil - Description for the mapping
-- @param opts: table|nil - Additional options
function M.imap(lhs, rhs, desc, opts)
  M.map("i", lhs, rhs, desc, opts)
end

-- Convenience function for visual mode mappings
-- @param lhs: string - The key combination to map
-- @param rhs: string|function - The command or function to execute
-- @param desc: string|nil - Description for the mapping
-- @param opts: table|nil - Additional options
function M.vmap(lhs, rhs, desc, opts)
  M.map("v", lhs, rhs, desc, opts)
end

-- Convenience function for terminal mode mappings
-- @param lhs: string - The key combination to map
-- @param rhs: string|function - The command or function to execute
-- @param desc: string|nil - Description for the mapping
-- @param opts: table|nil - Additional options
function M.tmap(lhs, rhs, desc, opts)
  M.map("t", lhs, rhs, desc, opts)
end

return M