-- Git integration plugins
-- This file contains plugins for Git workflow and version control

return {
    -- Gitsigns - Git Integration in Buffer
    -- Shows git changes in the sign column and provides git operations
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" }, -- Load when opening files
        keys = {
            -- Git hunk navigation
            { "<leader>gj", function() require("gitsigns").next_hunk() end, desc = "Next git hunk" },
            { "<leader>gk", function() require("gitsigns").prev_hunk() end, desc = "Previous git hunk" },

            -- Git operations
            { "<leader>gd", function() require("gitsigns").diffthis() end, desc = "Diff current file" },
            { "<leader>gs", function() require("gitsigns").stage_hunk() end, desc = "Stage current hunk" },
            { "<leader>gb", function() require("gitsigns").blame_line() end, desc = "Show git blame" },
            { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset current hunk" },
            { "<leader>gh", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk changes" },

            -- Toggle features
            { "<leader>gD", function() require("gitsigns").toggle_deleted() end, desc = "Toggle deleted lines" },
            { "<leader>gS", function() require("gitsigns").toggle_signs() end, desc = "Toggle git signs" },
        },
        config = function()
            require("gitsigns").setup({
                -- Signs for different types of changes
                signs = {
                    add = { text = "" }, -- Added lines
                    change = { text = "" }, -- Modified lines
                    delete = { text = "" }, -- Deleted lines
                    topdelete = { text = "" }, -- Deleted lines at top
                    changedelete = { text = "" }, -- Modified and deleted
                    untracked = { test = "" }, -- untracked
                },

                -- Display options
                signcolumn = true, -- Show signs in the sign column
                numhl = false, -- Don't highlight line numbers
                linehl = false, -- Don't highlight entire lines
                word_diff = false, -- Don't show word-level diffs

                -- Git directory monitoring
                watch_gitdir = {
                    interval = 1000, -- Check every second
                    follow_files = true -- Follow file renames
                },

                -- Track untracked files
                attach_to_untracked = true,

                -- Git blame configuration
                current_line_blame = false, -- Don't show blame by default
                current_line_blame_opts = {
                    virt_text = true, -- Show as virtual text
                    virt_text_pos = "eol", -- Position at end of line
                    delay = 1000, -- Delay before showing
                    ignore_whitespace = false, -- Consider whitespace changes
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",

                -- Performance and behavior
                sign_priority = 6, -- Priority for signs
                update_debounce = 100, -- Debounce updates
                status_formatter = nil, -- Use default status formatter
                max_file_length = 40000, -- Don't attach to very large files

                -- Preview window configuration
                preview_config = {
                    border = "single", -- Border style
                    style = "minimal", -- Minimal window style
                    relative = "cursor", -- Position relative to cursor
                    row = 0, -- Row offset
                    col = 1 -- Column offset
                },

                -- YADM support (Yet Another Dotfiles Manager)
                yadm = {
                    enable = false -- Disable YADM integration
                },
            })
        end,
    },
}
