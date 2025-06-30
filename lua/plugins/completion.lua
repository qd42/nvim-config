-- Completion and snippets configuration
-- This file sets up autocompletion, snippets, and related functionality

return {
    -- nvim-cmp - Main Completion Engine
    -- Provides intelligent autocompletion with multiple sources
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter", -- Load when entering insert mode
        dependencies = {
            -- Completion sources
            "hrsh7th/cmp-nvim-lsp", -- LSP completion
            "hrsh7th/cmp-nvim-lua", -- Neovim Lua API completion
            "hrsh7th/cmp-buffer", -- Buffer text completion
            "hrsh7th/cmp-path", -- File path completion
            "hrsh7th/cmp-cmdline", -- Command line completion
            "f3fora/cmp-spell", -- Spell check completion
            "zbirenbaum/copilot-cmp",
            -- Snippet engine and integration
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            -- UI enhancements
            "onsails/lspkind-nvim",

            -- AI-powered completion
            {
                "codota/tabnine-nvim",
                build = function()
                    -- Platform-specific build command
                    if vim.fn.has("win32") == 1 then
                        return "powershell.exe -ExecutionPolicy Bypass -File .\\dl_binaries.ps1"
                    else
                        return "./dl_binaries.sh"
                    end
                end,
                config = function()
                    require("tabnine").setup({
                        disable_auto_comment = true, -- Don't auto-comment
                        accept_keymap = "<A-i>", -- Alt+i to accept
                        dismiss_keymap = "<Leader>0", -- Leader+0 to dismiss
                        debounce_ms = 800, -- Delay before showing
                        suggestion_color = { gui = "#A0A0A0", cterm = 244 }, -- Suggestion color
                        exclude_filetypes = { "TelescopePrompt" }, -- Don't show in Telescope
                        log_file_path = nil, -- Disable logging
                    })
                end,
            },
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            cmp.setup({
                -- Snippet configuration
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- Use LuaSnip for expansion
                    end,
                },

                -- Key mappings for completion
                mapping = cmp.mapping.preset.insert({
                    -- Navigation
                    ["<Down>"] = cmp.mapping.select_next_item(), -- Next item
                    ["<Up>"] = cmp.mapping.select_prev_item(), -- Previous item

                    -- Scrolling in documentation
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll up
                    ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll down

                    -- Completion control
                    ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
                    ["<C-e>"] = cmp.mapping.abort(), -- Abort completion
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept completion

                    -- Super-Tab functionality
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item() -- Navigate completion
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump() -- Expand/jump snippet
                        else
                            fallback() -- Default tab behavior
                        end
                    end, { "i", "s" }),

                    -- Shift-Tab for reverse navigation
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item() -- Previous completion
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1) -- Jump back in snippet
                        else
                            fallback() -- Default shift-tab
                        end
                    end, { "i", "s" }),
                }),

                -- Completion sources with priorities
                sources = cmp.config.sources({
                    { name = "copilot", priority = 1100 }, -- Copilot
                    { name = "nvim_lsp", priority = 1000 }, -- Highest priority: LSP
                    { name = "luasnip", priority = 750 }, -- Snippets
                    { name = "nvim_lua", priority = 500 }, -- Neovim Lua API
                    { name = "path", priority = 250 }, -- File paths
                    { name = "spell", priority = 100, option = { -- Spell checking
                        keep_all_entries = false, -- Don't keep all entries
                        enable_in_context = function()
                            return true -- Always enable
                        end,
                    } },
                }, {
                    { name = "buffer", priority = 50 }, -- Buffer text (fallback)
                }),

                -- Formatting with icons and source information
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text", -- Show both icon and text
                        maxwidth = 50, -- Maximum width
                        ellipsis_char = "...", -- Truncation indicator
                        menu = {
                            -- Source indicators
                            buffer = "﬘",
                            nvim_lsp = "",
                            nvim_lua = "",
                            path = "פּ",
                            cmdline = ":",
                            luasnip = "",
                            spell = "暈",
                            copilot = "",
                        },
                    }),
                },

                -- Window styling
                window = {
                    completion = cmp.config.window.bordered(), -- Bordered completion menu
                    documentation = cmp.config.window.bordered(), -- Bordered documentation
                },

                -- Experimental features
                experimental = {
                    ghost_text = true, -- Show preview of completion
                },
            })

            -- Command line completion for search
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" } -- Complete from buffer content
                }
            })

            -- Command line completion for commands
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" } -- File paths first
                }, {
                    { name = "cmdline" } -- Command names second
                })
            })
        end,
    },

    -- LuaSnip - Snippet Engine
    -- Fast and feature-rich snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Use version 2.x
        build = function()
            -- Only build jsregexp on non-Windows systems
            if vim.fn.has("win32") == 0 then
                return "make install_jsregexp"
            end
        end,
        dependencies = {
            "rafamadriz/friendly-snippets", -- Collection of snippets for various languages
        },
        keys = {
            -- Snippet navigation keys
            { "<Tab>", function()
                if require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                end
            end, mode = "i", desc = "Expand snippet or jump to next placeholder" },

            { "<S-Tab>", function()
                if require("luasnip").jumpable(-1) then
                    require("luasnip").jump(-1)
                end
            end, mode = "i", desc = "Jump to previous placeholder" },

            { "<C-E>", function()
                if require("luasnip").choice_active() then
                    require("luasnip").change_choice(1)
                end
            end, mode = { "i", "s" }, desc = "Cycle through snippet choices" },
        },
        config = function()
            -- Load snippets from friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- Snippet completion source for nvim-cmp
    { "saadparwaiz1/cmp_luasnip", lazy = true },

    -- Collection of snippets for various programming languages
    { "rafamadriz/friendly-snippets", lazy = true },
}
