-- Bootstrap lazy.nvim plugin manager
-- This is the main entry point for the Neovim configuration
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- If lazy.nvim is not installed, clone it from GitHub
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none", -- Shallow clone for faster download
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- Use stable branch
        lazypath,
    })
end
-- Add lazy.nvim to the runtime path so it can be required
vim.opt.rtp:prepend(lazypath)

require("utils.colors").setup()
-- Load core configuration modules
require("core")

-- Setup plugins using lazy.nvim
require("plugins")

-- Load local configuration file if it exists
-- This allows for machine-specific overrides without affecting the main config
local local_config = vim.fn.stdpath("config") .. "/local.lua"
if vim.fn.filereadable(local_config) == 1 then
    dofile(local_config)
end
