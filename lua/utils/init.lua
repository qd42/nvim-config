-- Utility functions module
-- This file contains helper functions used throughout the configuration

local M = {} -- Module table

-- Check if a file exists
-- @param name: string - The path to the file to check
-- @return boolean - True if file exists and is readable, false otherwise
function M.file_exists(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

-- Safely require a module with error handling
-- @param module: string - The module name to require
-- @return any|nil - The required module or nil if it failed to load
function M.safe_require(module)
    local ok, result = pcall(require, module)
    if not ok then
        vim.notify("Error loading " .. module .. ": " .. result, vim.log.levels.ERROR)
        return nil
    end
    return result
end

-- Get the current operating system name
-- @return string - The OS name (e.g., "Linux", "Darwin", "Windows_NT")
function M.get_os()
    return vim.loop.os_uname().sysname
end

return M

