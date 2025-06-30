-- Core configuration loader
-- This file orchestrates loading of all core configuration modules
-- in the correct order to ensure proper initialization

require("core.options") -- Load Vim options and settings
require("core.keymaps") -- Load key mappings
require("core.autocmds") -- Load autocommands and event handlers

