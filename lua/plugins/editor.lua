-- Editor enhancement plugins
-- This file contains plugins that enhance the core editing experience

return {
    -- TreeSitter Syntax Highlighting
    -- Provides advanced syntax highlighting, indentation, and text objects
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            -- Windows-specific build handling due to compilation issues
            if vim.fn.has("win32") == 1 then
                vim.notify("TreeSitter installed. Run ':TSInstall lua vim' manually to install parsers.",
                    vim.log.levels.INFO)
                return nil -- Don't auto-build on Windows
            else
                return ":TSUpdate" -- Auto-update parsers on Unix systems
            end
        end,
        event = { "BufReadPost", "BufNewFile" }, -- Load when opening files
        config = function()
            -- Windows-specific configuration to handle file locking issues
            if vim.fn.has("win32") == 1 then
                local install = require("nvim-treesitter.install")

                -- Disable git-based installation to avoid file locks
                install.prefer_git = false

                -- Configure curl with safer options for Windows
                install.command_extra_args = {
                    curl = { "--silent", "--show-error", "--location", "--connect-timeout", "60", "--max-time", "300" },
                }

                -- Detect available compilers on Windows
                local available_compilers = {}
                for _, compiler in ipairs({ "gcc", "clang", "cl", "zig" }) do
                    if vim.fn.executable(compiler) == 1 then
                        table.insert(available_compilers, compiler)
                    end
                end

                if #available_compilers > 0 then
                    install.compilers = available_compilers
                    vim.notify("TreeSitter will use compiler: " .. available_compilers[1], vim.log.levels.INFO)
                else
                    vim.notify("No suitable compiler found. TreeSitter parsers may not compile.", vim.log.levels.WARN)
                end

                -- Override directory removal function for Windows compatibility
                local original_rmdir = install.rmdir
                install.rmdir = function(path)
                    if vim.fn.has("win32") == 1 then
                        -- Use PowerShell for more reliable directory removal
                        local ps_cmd = string.format(
                            'powershell -Command "if (Test-Path \'%s\') { Remove-Item -Path \'%s\' -Recurse -Force -ErrorAction SilentlyContinue }"'
                            ,
                            path, path
                        )
                        return os.execute(ps_cmd)
                    else
                        return original_rmdir(path)
                    end
                end
            end

            -- Main TreeSitter configuration
            require("nvim-treesitter.configs").setup({
                -- Language parsers to install automatically
                ensure_installed = vim.fn.has("win32") == 1 and {} or {
                    "c", "cpp", "lua", "python", "rust", "javascript", "typescript",
                    "html", "css", "json", "yaml", "markdown", "bash", "vim", "vimdoc", "query"
                },

                -- Platform-specific installation settings
                auto_install = vim.fn.has("win32") == 0, -- Disable auto-install on Windows
                sync_install = vim.fn.has("win32") == 1, -- Use sync install on Windows

                -- Syntax highlighting configuration
                highlight = {
                    enable = true,
                    -- Use additional vim regex highlighting on Windows as fallback
                    additional_vim_regex_highlighting = vim.fn.has("win32") == 1,
                },

                -- Smart indentation
                indent = {
                    enable = true,
                    -- Disable problematic languages on Windows
                    disable = vim.fn.has("win32") == 1 and { "python", "yaml", "html" } or {},
                },

                -- Incremental selection with TreeSitter
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>", -- Start selection
                        node_incremental = "<C-space>", -- Expand selection
                        scope_incremental = false, -- Disabled
                        node_decremental = "<bs>", -- Shrink selection
                    },
                },
            })

            -- Windows-specific safe installation commands
            if vim.fn.has("win32") == 1 then
                -- Command to safely install individual parsers
                vim.api.nvim_create_user_command("TSInstallSafe", function(opts)
                    local parser = opts.args
                    if parser == "" then
                        vim.notify("Usage: :TSInstallSafe <parser_name>", vim.log.levels.ERROR)
                        return
                    end

                    vim.notify("Installing " .. parser .. " parser...", vim.log.levels.INFO)

                    -- Clean up any existing parser directory first
                    local parser_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser-info/" .. parser
                    if vim.fn.isdirectory(parser_dir) == 1 then
                        local cleanup_cmd = string.format(
                            'powershell -Command "Remove-Item -Path \'%s\' -Recurse -Force -ErrorAction SilentlyContinue"'
                            ,
                            parser_dir:gsub("/", "\\")
                        )
                        os.execute(cleanup_cmd)
                    end

                    -- Attempt to install the parser
                    local success, err = pcall(function()
                        vim.cmd("TSInstall! " .. parser)
                    end)

                    if success then
                        vim.notify("Successfully installed " .. parser .. " parser!", vim.log.levels.INFO)
                    else
                        vim.notify("Failed to install " .. parser .. " parser: " .. tostring(err), vim.log.levels.ERROR)
                    end
                end, {
                    nargs = 1,
                    complete = function()
                        return { "lua", "vim", "c", "cpp", "python", "javascript", "typescript", "json", "markdown",
                            "html", "css" }
                    end,
                })

                -- Command to install essential parsers with delays
                vim.api.nvim_create_user_command("TSInstallEssential", function()
                    local parsers = { "lua", "vim", "vimdoc", "query" }
                    vim.notify("Installing essential parsers: " .. table.concat(parsers, ", "), vim.log.levels.INFO)

                    for i, parser in ipairs(parsers) do
                        vim.defer_fn(function()
                            vim.cmd("TSInstallSafe " .. parser)
                        end, i * 3000) -- 3 second delay between installations
                    end
                end, {})

                -- Provide usage information for Windows users
                vim.defer_fn(function()
                    vim.notify("TreeSitter enabled on Windows. Use :TSInstallEssential or :TSInstallSafe <parser> to install parsers."
                        , vim.log.levels.INFO)
                end, 2000)
            end
        end,
    },

    -- TreeSitter Text Objects
    -- Provides text objects based on TreeSitter syntax tree
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj
                        keymaps = {
                            -- Function text objects
                            ["af"] = "@function.outer", -- Select entire function
                            ["if"] = "@function.inner", -- Select function body
                            -- Class text objects
                            ["ac"] = "@class.outer", -- Select entire class
                            ["ic"] = "@class.inner", -- Select class body
                            -- Parameter text objects
                            ["aa"] = "@parameter.outer", -- Select parameter with separators
                            ["ia"] = "@parameter.inner", -- Select parameter content
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- Set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer", -- Next function start
                            ["]]"] = "@class.outer", -- Next class start
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer", -- Next function end
                            ["]["] = "@class.outer", -- Next class end
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer", -- Previous function start
                            ["[["] = "@class.outer", -- Previous class start
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer", -- Previous function end
                            ["[]"] = "@class.outer", -- Previous class end
                        },
                    },
                },
            })
        end,
    },

    -- Telescope Fuzzy Finder
    -- Powerful fuzzy finder for files, buffers, and more
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
        cmd = "Telescope", -- Load on command
        keys = {
            -- File and content finding
            { "<leader>tt", "<cmd>Telescope<cr>", desc = "Telescope" },
            { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
            { "<leader>ts", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
            { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>to", "<cmd>Telescope oldfiles<cr>", desc = "Old files" },

            -- Command and search history
            { "<leader>tc", "<cmd>Telescope command_history<cr>", desc = "Command history" },
            { "<leader>tS", "<cmd>Telescope search_history<cr>", desc = "Search history" },

            -- Vim internals
            { "<leader>tq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
            { "<leader>tr", "<cmd>Telescope registers<cr>", desc = "Registers" },

            -- LSP integration
            { "<leader>tR", "<cmd>Telescope lsp_references<cr>", desc = "LSP references" },
            { "<leader>tI", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Incoming calls" },
            { "<leader>tO", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "Outgoing calls" },
            { "<leader>tD", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
            { "<leader>tT", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type definitions" },

            -- Utility
            { "<leader>ta", "<cmd>Telescope resume<cr>", desc = "Resume last search" },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key" -- Show help in insert mode
                        }
                    }
                },
            })
        end,
    },

    -- Trouble.nvim - Diagnostics and Issue Browser
    -- Beautiful list for showing diagnostics, references, telescope results, quickfix and location lists
    {
        "folke/trouble.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" }, -- Requires icons
        cmd = "Trouble", -- Load on command
        keys = {
            -- Main trouble interface
            { "<leader>rt", "<cmd>Trouble<cr>", desc = "Trouble" },

            -- Diagnostics
            { "<leader>rd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Document diagnostics" },
            { "<leader>rD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },

            -- LSP integration
            { "<leader>rR", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP references" },
            { "<leader>rI", "<cmd>Trouble lsp_incoming_calls toggle<cr>", desc = "Incoming calls" },
            { "<leader>rO", "<cmd>Trouble lsp_outgoing_calls toggle<cr>", desc = "Outgoing calls" },
            { "<leader>rs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Document symbols" },
            { "<leader>rS", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP definitions/references" },

            -- List management
            { "<leader>rq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
            { "<leader>rl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },

            -- Navigation
            { "<leader>rj", function()
                if require("trouble").is_open() then
                    require("trouble").next({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cnext)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end, desc = "Next trouble/quickfix item" },

            { "<leader>rk", function()
                if require("trouble").is_open() then
                    require("trouble").prev({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end, desc = "Previous trouble/quickfix item" },
        },
        config = function()
            require("trouble").setup({
                -- Window and positioning
                position = "bottom", -- Position of the list (top, bottom, left, right)
                height = 10, -- Height of the trouble list when position is top or bottom
                width = 50, -- Width of the list when position is left or right
                padding = true, -- Add an extra new line on top of the list

                -- Icon configuration - must be a table, not boolean
                icons = {
                    indent        = {
                        top         = "│ ",
                        middle      = "├╴",
                        last        = "└╴",
                        fold_open   = " ",
                        fold_closed = " ",
                        ws          = "  ",
                    },
                    folder_closed = " ",
                    folder_open   = " ",
                    kinds         = {
                        Array         = " ",
                        Boolean       = "󰨙 ",
                        Class         = " ",
                        Constant      = "󰏿 ",
                        Constructor   = " ",
                        Enum          = " ",
                        EnumMember    = " ",
                        Event         = " ",
                        Field         = " ",
                        File          = " ",
                        Function      = "󰊕 ",
                        Interface     = " ",
                        Key           = " ",
                        Method        = "󰊕 ",
                        Module        = " ",
                        Namespace     = "󰦮 ",
                        Null          = " ",
                        Number        = "󰎠 ",
                        Object        = " ",
                        Operator      = " ",
                        Package       = " ",
                        Property      = " ",
                        String        = " ",
                        Struct        = "󰆼 ",
                        TypeParameter = " ",
                        Variable      = "󰀫 ",
                    },
                },

                -- Appearance settings
                fold_open = "", -- Icon used for open folds
                fold_closed = "", -- Icon used for closed folds
                group = true, -- Group results by file
                cycle_results = true, -- Cycle item list when reaching beginning or end

                -- Action keys
                keys = {
                    ["?"] = "help",
                    r = "refresh",
                    R = "toggle_refresh",
                    q = "close",
                    o = "jump_close",
                    ["<esc>"] = "cancel",
                    ["<cr>"] = "jump",
                    ["<2-leftmouse>"] = "jump",
                    ["<c-s>"] = "jump_split",
                    ["<c-v>"] = "jump_vsplit",
                    -- Go to the issue without closing trouble
                    ["<tab>"] = "jump",
                    ["<c-x>"] = "jump_split",
                    ["<c-t>"] = "jump_tab",
                    dd = "delete",
                    d = { action = "delete", mode = "v" },
                    i = "inspect",
                    p = "preview",
                    P = "toggle_preview",
                    zo = "fold_open",
                    zO = "fold_open_recursive",
                    zc = "fold_close",
                    zC = "fold_close_recursive",
                    za = "fold_toggle",
                    zA = "fold_toggle_recursive",
                    zm = "fold_more",
                    zM = "fold_close_all",
                    zr = "fold_reduce",
                    zR = "fold_open_all",
                    zx = "fold_update",
                    zX = "fold_update_all",
                    zn = "fold_disable",
                    zN = "fold_enable",
                    zi = "fold_toggle_enable",
                    gb = { -- example of a custom action that toggles the active view filter
                        action = function(view)
                            view:filter({ buf = 0 }, { toggle = true })
                        end,
                        desc = "Toggle Current Buffer Filter",
                    },
                    s = { -- example of a custom action that toggles the severity
                        action = function(view)
                            local f = view:get_filter("severity")
                            local severity = ((f and f.filter.severity or 0) + 1) % 5
                            view:filter({ severity = severity },
                                { id = "severity", template = "{hl:Title}SEVERITY{hl} {severity}" })
                        end,
                        desc = "Toggle Severity Filter",
                    },
                },

                -- Mode configuration
                modes = {
                    -- Sources of trouble
                    lsp_references = {
                        params = {
                            include_declaration = true,
                        },
                    },
                    -- Example of a custom mode
                    mydiags = {
                        mode = "diagnostics",
                        filter = {
                            any = {
                                buf = 0, -- current buffer
                                {
                                    severity = vim.diagnostic.severity.ERROR, -- errors only
                                    -- limit to files in the current project
                                    function(item)
                                        return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                                    end,
                                },
                            },
                        },
                    },
                },
            })
        end,
    },

    -- Comment.nvim
    -- Smart commenting plugin with TreeSitter integration
    {
        "numToStr/Comment.nvim",
        keys = {
            -- Line commenting
            { "gcc", mode = "n", desc = "Comment toggle current line" },
            { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },

            -- Block commenting
            { "gbc", mode = "n", desc = "Comment toggle current block" },
            { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
        },
        config = function()
            require("Comment").setup() -- Use default configuration
        end,
    },

    -- Leap Motion Navigation
    -- Fast navigation by searching for character pairs
    {
        "ggandor/leap.nvim",
        keys = {
            { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
            { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
            { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
        },
        config = function()
            require("leap").add_default_mappings() -- Use default key mappings
        end,
    },

    -- ToggleTerm
    -- Better terminal integration with floating and persistent terminals
    {
        "akinsho/toggleterm.nvim",
        version = "*", -- Use latest stable version
        keys = {
            { "<leader>vt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
        },
        config = function()
            require("toggleterm").setup({
                size = 20, -- Terminal size
                open_mapping = [[<c-\>]], -- Default key mapping
                hide_numbers = true, -- Hide line numbers in terminal
                shade_terminals = true, -- Shade background
                shading_factor = 2, -- Shading intensity
                start_in_insert = true, -- Start in insert mode
                insert_mappings = true, -- Apply mappings in insert mode
                persist_size = true, -- Remember terminal size
                direction = "float", -- Float the terminal
                close_on_exit = true, -- Close when process exits
                shell = vim.o.shell, -- Use system shell
                float_opts = {
                    border = "curved", -- Terminal border style
                },
            })
        end,
    },

    -- Clang Format
    -- Code formatting for C/C++ files
    {
        "rhysd/vim-clang-format",
        ft = { "c", "cpp" }, -- Load only for C/C++ files
        keys = {
            { "<leader>vf", "<cmd>ClangFormat<cr>", desc = "Format code" },
        },
    },

    -- nvim-colorizer - Color Highlighting
    -- Highlights color codes in their actual colors
    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufReadPost", "BufNewFile" }, -- Load when opening files
        keys = {
            { "<leader>vc", "<cmd>ColorizerToggle<cr>", desc = "Toggle colorizer" },
            { "<leader>vC", "<cmd>ColorizerReloadAllBuffers<cr>", desc = "Reload colorizer for all buffers" },
        },
        config = function()
            require("colorizer").setup({
                -- File types to enable colorizer for
                filetypes = {
                    "*", -- Enable for all file types by default
                    -- File-specific configurations
                    css = {
                        rgb_fn = true, -- Enable RGB() functions
                        hsl_fn = true, -- Enable HSL() functions
                        css = true, -- Enable CSS colors (names like 'red', 'blue')
                        css_fn = true, -- Enable CSS functions
                    },
                    scss = {
                        rgb_fn = true,
                        hsl_fn = true,
                        css = true,
                        css_fn = true,
                    },
                    sass = {
                        rgb_fn = true,
                        hsl_fn = true,
                        css = true,
                        css_fn = true,
                    },
                    html = {
                        rgb_fn = true,
                        css = true,
                        css_fn = true,
                    },
                    javascript = {
                        rgb_fn = true, -- Enable RGB() function highlighting
                    },
                    typescript = {
                        rgb_fn = true,
                    },
                    vue = {
                        rgb_fn = true,
                        css = true,
                        css_fn = true,
                    },
                    svelte = {
                        rgb_fn = true,
                        css = true,
                        css_fn = true,
                    },
                },

                -- Default options for all file types
                default_options = {
                    RGB = true, -- #RGB hex codes (e.g., #F00)
                    RRGGBB = true, -- #RRGGBB hex codes (e.g., #FF0000)
                    RRGGBBAA = true, -- #RRGGBBAA hex codes with alpha (e.g., #FF0000FF)
                    AARRGGBB = true, -- #AARRGGBB hex codes with alpha (e.g., #FFFF0000)
                    rgb_fn = true, -- RGB(R,G,B) and rgb(R,G,B) functions
                    hsl_fn = false, -- HSL() functions (disabled by default)
                    css = false, -- CSS color names (disabled by default for most files)
                    css_fn = false, -- CSS functions (disabled by default for most files)

                    -- Display mode
                    mode = "background", -- Options: 'foreground', 'background', 'virtualtext'

                    -- Virtual text options (when mode = "virtualtext")
                    virtualtext = "■", -- Character to show in virtual text

                    -- Parser options
                    tailwind = false, -- Disable Tailwind CSS colors by default
                    sass = { enable = false, parsers = { "css" } }, -- Sass support
                },

                -- Buffer-local options
                buftypes = {
                    "*", -- Enable for all buffer types
                    -- Exclude specific buffer types
                    "!prompt", -- Don't enable for prompt buffers
                    "!popup", -- Don't enable for popup buffers
                },
            })

            -- Auto-attach to new buffers
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
                group = vim.api.nvim_create_augroup("ColorizerAttach", { clear = true }),
                callback = function()
                    -- Auto-attach colorizer to supported file types
                    local ft = vim.bo.filetype
                    if ft and ft ~= "" then
                        require("colorizer").attach_to_buffer(0)
                    end
                end,
            })
        end,
    },

    -- Virtual Types
    -- Show type annotations for languages like C/C++/Rust
    --[[ {
    "jubnzv/virtual-types.nvim",
    ft = { "c", "cpp", "rust" }, -- Load only for specific file types
    config = function()
      require("virtualtypes").setup() -- Use default configuration
    end,
  }, ]]
}
