-- UI and appearance plugins
-- This file contains plugins that enhance the visual appearance and user interface

return {
    -- Feline Status Line
    -- A minimal, fast, and customizable statusline
    {
        "feline-nvim/feline.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" }, -- Requires icons
        config = function()
            require("feline").setup() -- Use default configuration
        end,
    },

    -- Nvim Tree File Explorer
    -- A modern file explorer sidebar
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "kyazdani42/nvim-web-devicons" }, -- Requires icons
        config = function()
            require("nvim-tree").setup({}) -- Use default configuration
        end,
    },

    -- Web Dev Icons
    -- Provides file type icons for various plugins
    {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({
                default = true, -- Enable default icons
                override = {
                    -- Custom icon for zsh files
                    zsh = {
                        icon = "",
                        color = "#428850",
                        cterm_color = "65",
                        name = "Zsh"
                    },
                },
            })
        end,
    },

    -- Vim Startify Start Screen
    -- Provides a fancy start screen with recent files and sessions
    { "mhinz/vim-startify" },

    -- Which Key Help System
    -- Shows available keybindings in popup
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup() -- Use default configuration
        end,
    },

    -- Shade Inactive Windows
    -- Dims inactive windows to highlight the active one
    {
        "sunjon/shade.nvim",
        config = function()
            require("shade").setup({
                overlay_opacity = 66, -- Opacity level for inactive windows
                opacity_step = 1, -- Step size for opacity changes
                keys = {
                    brightness_up = "<C-Up>", -- Increase brightness
                    brightness_down = "<C-Down>", -- Decrease brightness
                    toggle = "<leader>vb", -- Toggle shade on/off
                }
            })
        end,
    },

    -- Hydra Modal Key Bindings
    -- Create modal keybinding interfaces (like vim-which-key but more powerful)
    {
        "nvimtools/hydra.nvim",
        config = function()
            local Hydra = require("hydra")

            -- Window Management Hydra
            -- Provides a modal interface for window operations
            Hydra({
                name = "Window Management",
                mode = { "n" }, -- Normal mode only
                body = "<leader>w", -- Activation key
                heads = {
                    -- Window navigation
                    { "h", "<C-w>h", { desc = "Move left" } },
                    { "j", "<C-w>j", { desc = "Move down" } },
                    { "k", "<C-w>k", { desc = "Move up" } },
                    { "l", "<C-w>l", { desc = "Move right" } },

                    -- Window resizing
                    { "H", "<C-w><", { desc = "Resize left" } },
                    { "L", "<C-w>>", { desc = "Resize right" } },
                    { "K", "<C-w>-", { desc = "Resize up" } },
                    { "J", "<C-w>+", { desc = "Resize down" } },

                    -- Other window operations
                    { "e", "<C-w>=", { desc = "Equalize windows" } },
                    { "Q", ":q<cr>", { desc = "Quit window", exit = true } },

                    -- Exit keys
                    { "q", nil, { exit = true, nowait = true } },
                    { "<Esc>", nil, { exit = true, nowait = true } },
                },
            })
        end,
    },
}
