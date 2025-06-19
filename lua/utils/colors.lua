local M = {}

local colors = {

    blue       = "#4A7CFF", -- blue
    orange     = "#FF9F25", -- orange
    green      = "#5AE637", -- green
    red        = "#FF4348", -- red
    teal       = "#25F2F2", -- teal
    purple     = "#B048FF", -- purple
    yellow     = "#FFE600", -- yellow
    magenta    = "#FF48D8", -- magenta
    lime       = "#BDFF1A", -- lime
    skyblue    = "#25B7FF", -- sky blue
    brown      = "#D67041", -- brown
    coral      = "#FF6E48", -- coral
    lavender   = "#B976FF", -- lavender
    mint       = "#24FFB3", -- mint
    gray       = "#9BADAD", -- gray
    salmon     = "#FF7A7E", -- salmon
    olive      = "#C9E619", -- olive
    periwinkle = "#6E9CFF", -- periwinkle
    rust       = "#FF7825", -- rust
    turquoise  = "#25FFDC", -- turquoise
    maroon     = "#FF428A", -- maroon
    gold       = "#FFCC19", -- gold
    emerald    = "#19FF96", -- emerald
    indigo     = "#7852FF",  -- indigo
    pastel_blue       = "#7293CB", -- pastel blue
    pastel_orange     = "#E1974C", -- pastel orange
    pastel_green      = "#84BA5B", -- pastel green
    pastel_red        = "#D35E60", -- pastel red
    pastel_teal       = "#5DBDBD", -- pastel teal
    pastel_purple     = "#9067A7", -- pastel purple
    pastel_yellow     = "#CCC210", -- pastel yellow
    pastel_magenta    = "#C867A7", -- pastel magenta
    pastel_lime       = "#A6C24D", -- pastel lime
    pastel_skyblue    = "#67A7D0", -- pastel sky blue
    pastel_brown      = "#AB6857", -- pastel brown
    pastel_coral      = "#D37867", -- pastel coral
    pastel_lavender   = "#A387CB", -- pastel lavender
    pastel_mint       = "#67C39A", -- pastel mint
    pastel_gray       = "#808585", -- pastel gray
    pastel_salmon     = "#D38789", -- pastel salmon
    pastel_olive      = "#A6BA4C", -- pastel olive
    pastel_periwinkle = "#8293CB", -- pastel periwinkle
    pastel_rust       = "#C27349", -- pastel rust
    pastel_turquoise  = "#60BDAA", -- pastel turquoise
    pastel_maroon     = "#BA5B7E", -- pastel maroon
    pastel_gold       = "#D3AA4C", -- pastel gold
    pastel_emerald    = "#60B989", -- pastel emerald
    pastel_indigo     = "#7867A7",  -- pastel indigo

    -- Additional colors for UI elements
    bg         = "#000000",
    fg         = "#DDDDDD",
    bg_dark    = "#000000",
    bg_light   = "#333842",
    bg_lighter = "#3e4452",
    bg_subtle  = "#2c323c",
    border     = "#4b5263",
    comment    = "#7f8c98",
    selection  = "#3e4452",
    visual     = "#3e4452",
    cursor     = "#abb2bf",
    none       = "NONE"
}

function M.setup()
    -- Clear existing highlights
    vim.cmd('highlight clear')
    if vim.g.syntax_on then
        vim.cmd('syntax reset')
    end

    -- Set colorscheme name
    vim.g.colors_name = "softcolors"

    -- Enable termguicolors if available
    if vim.fn.has('termguicolors') == 1 then
        vim.cmd('set termguicolors')
    end

    -- Define highlight groups
    local highlights = {
        -- Standard syntax groups
        Normal          = { fg = colors.fg, bg = colors.bg },
        NormalFloat     = { fg = colors.fg, bg = colors.bg_light },
        Comment         = { fg = colors.comment, italic = true },
        Constant        = { fg = colors.grey},
        String          = { fg = colors.pastel_green, italic = true },
        Character       = { fg = colors.pastel_mint, italic = true },
        Number          = { fg = colors.pastel_teal},
        Boolean         = { fg = colors.pastel_teal},
        Float           = { fg = colors.pastel_teal},
        Identifier      = { fg = colors.pastel_skyblue},
        Function        = { fg = colors.pastel_periwinkle},
        Statement       = { fg = colors.pastel_turquoise},
        Conditional     = { fg = colors.pastel_turquoise},
        Repeat          = { fg = colors.pastel_turquoise},
        Label           = { fg = colors.pastel_magenta},
        Operator        = { fg = colors.fg },
        Keyword         = { fg = colors.pastel_purple},
        Exception       = { fg = colors.pastel_red},
        PreProc         = { fg = colors.pastel_yellow},
        Include         = { fg = colors.pastel_mint},
        Define          = { fg = colors.pastel_purple},
        Macro           = { fg = colors.pastel_orange},
        PreCondit       = { fg = colors.pastel_purple},
        Type            = { fg = colors.pastel_skyblue},
        StorageClass    = { fg = colors.pastel_blue},
        Structure       = { fg = colors.pastel_blue},
        Typedef         = { fg = colors.pastel_gold},
        Special         = { fg = colors.pastel_magenta},
        SpecialChar     = { fg = colors.pastel_magenta},
        Tag             = { fg = colors.pastel_yellow},
        Delimiter       = { fg = colors.fg },
        SpecialComment  = { fg = colors.comment, italic = true },
        Debug           = { fg = colors.red },
        Underlined      = { fg = colors.pastel_magenta, underline = true },
        Ignore          = { fg = colors.gray },
        Error           = { fg = colors.red, bold = true },
        Todo            = { fg = colors.pastel_yellow, bold = true },

        -- Editor UI
        Cursor          = { fg = colors.bg, bg = colors.cursor },
        CursorLine      = { bg = colors.bg_subtle },
        CursorColumn    = { bg = colors.bg_subtle },
        ColorColumn     = { bg = colors.bg_subtle },
        LineNr          = { fg = colors.gray },
        CursorLineNr    = { fg = colors.pastel_orange, bold = true },
        VertSplit       = { fg = colors.border, bg = colors.bg },
        SignColumn      = { fg = colors.fg, bg = colors.bg },
        StatusLine      = { fg = colors.fg, bg = colors.bg_light },
        StatusLineNC    = { fg = colors.gray, bg = colors.bg_light },
        Pmenu           = { fg = colors.fg, bg = colors.bg_light },
        PmenuSel        = { fg = colors.bg, bg = colors.blue },
        PmenuSbar       = { bg = colors.bg_lighter },
        PmenuThumb      = { bg = colors.gray },
        TabLine         = { fg = colors.gray, bg = colors.bg_light },
        TabLineFill     = { fg = colors.gray, bg = colors.bg },
        TabLineSel      = { fg = colors.fg, bg = colors.bg },
        Title           = { fg = colors.pastel_blue, bold = true },
        Visual          = { bg = colors.visual },
        VisualNOS       = { bg = colors.visual },
        WarningMsg      = { fg = colors.orange, bold = true },
        ErrorMsg        = { fg = colors.red, bold = true },
        WildMenu        = { fg = colors.fg, bg = colors.blue },
        Directory       = { fg = colors.blue },
        MatchParen      = { fg = colors.yellow, bold = true },
        SpecialKey      = { fg = colors.gray },
        NonText         = { fg = colors.gray },
        Whitespace      = { fg = colors.gray },
        Folded          = { fg = colors.comment, bg = colors.bg_subtle },
        FoldColumn      = { fg = colors.gray, bg = colors.bg },
        Search          = { fg = colors.bg, bg = colors.yellow },
        IncSearch       = { fg = colors.bg, bg = colors.orange },
        Substitute      = { fg = colors.bg, bg = colors.green },
        QuickFixLine    = { bg = colors.bg_light, bold = true },

        -- Diff highlighting
        DiffAdd         = { fg = colors.green, bg = colors.bg_subtle },
        DiffChange      = { fg = colors.yellow, bg = colors.bg_subtle },
        DiffDelete      = { fg = colors.red, bg = colors.bg_subtle },
        DiffText        = { fg = colors.blue, bg = colors.bg_light },

        -- Git highlighting
        gitcommitSelectedFile = { fg = colors.green },
        gitcommitDiscardedFile = { fg = colors.red },

        -- Spell checking
        SpellBad        = { fg = colors.red, underline = true },
        SpellCap        = { fg = colors.blue, underline = true },
        SpellRare       = { fg = colors.purple, underline = true },
        SpellLocal      = { fg = colors.green, underline = true },

        -- Diagnostic
        DiagnosticError = { fg = colors.red },
        DiagnosticWarn  = { fg = colors.yellow },
        DiagnosticInfo  = { fg = colors.blue },
        DiagnosticHint  = { fg = colors.green },
        DiagnosticUnderlineError = { underline = true, sp = colors.red },
        DiagnosticUnderlineWarn  = { underline = true, sp = colors.yellow },
        DiagnosticUnderlineInfo  = { underline = true, sp = colors.blue },
        DiagnosticUnderlineHint  = { underline = true, sp = colors.green },
        DiagnosticVirtualTextHint = { fg = colors.red, bg = colors.white},

        -- LSP highlighting
        LspReferenceText  = { bg = colors.bg_light },
        LspReferenceRead  = { bg = colors.bg_light },
        LspReferenceWrite = { bg = colors.bg_light },
        LspCodeLens       = { fg = colors.comment },
        LspSignatureActiveParameter = { fg = colors.yellow, bold = true },
        -- New LSP Highlight Groups (Neovim 0.10+)
        LspDiagnosticsDefaultError = { fg = colors.red },
        LspDiagnosticsDefaultWarning = { fg = colors.yellow },
        LspDiagnosticsDefaultInformation = { fg = colors.blue },
        LspDiagnosticsDefaultHint = { fg = colors.green },
        LspDiagnosticsUnderlineError = { underline = true, sp = colors.red },
        LspDiagnosticsUnderlineWarning = { underline = true, sp = colors.yellow },
        LspDiagnosticsUnderlineInformation = { underline = true, sp = colors.blue },
        LspDiagnosticsUnderlineHint = { underline = true, sp = colors.green },
        LspDiagnosticsVirtualTextError = { fg = colors.red, bg = colors.bg_subtle },
        LspDiagnosticsVirtualTextWarning = { fg = colors.yellow, bg = colors.bg_subtle },
        LspDiagnosticsVirtualTextInformation = { fg = colors.blue, bg = colors.bg_subtle },
        LspDiagnosticsVirtualTextHint = { fg = colors.green, bg = colors.bg_subtle },
        LspDiagnosticsFloatingError = { fg = colors.red },
        LspDiagnosticsFloatingWarning = { fg = colors.yellow },
        LspDiagnosticsFloatingInformation = { fg = colors.blue },
        LspDiagnosticsFloatingHint = { fg = colors.green },
        LspDiagnosticsSignError = { fg = colors.red },
        LspDiagnosticsSignWarning = { fg = colors.yellow },
        LspDiagnosticsSignInformation = { fg = colors.blue },
        LspDiagnosticsSignHint = { fg = colors.green },

        -- Code Actions and Symbol References
        LspCodeAction = { fg = colors.pastel_orange },
        LspInfoBorder = { fg = colors.border, bg = colors.bg_dark },
        LspHoverHighlight = { bg = colors.bg_subtle },
        LspDefinitionHighlight = { bg = colors.bg_lighter },
        LspSelectionHighlight = { bg = colors.bg_light },







        -- Neovim-specific
        healthError          = { fg = colors.red },
        healthSuccess        = { fg = colors.green },
        healthWarning        = { fg = colors.orange },

        -- NvimTree
        NvimTreeNormal           = { fg = colors.fg, bg = colors.bg_dark },
        NvimTreeRootFolder       = { fg = colors.pastel_skyblue, bold = true },
        NvimTreeFolderName       = { fg = colors.pastel_blue },
        NvimTreeFolderIcon       = { fg = colors.pastel_blue },
        NvimTreeEmptyFolderName  = { fg = colors.gray },
        NvimTreeOpenedFolderName = { fg = colors.blue },
        NvimTreeExecFile         = { fg = colors.green, bold = true },
        NvimTreeOpenedFile       = { fg = colors.blue},
        NvimTreeSpecialFile      = { fg = colors.pastel_purple, underline = true },
        NvimTreeImageFile        = { fg = colors.pastel_orange },
        NvimTreeIndentMarker     = { fg = colors.gray },
        NvimTreeGitDirty         = { fg = colors.pastel_yellow },
        NvimTreeGitStaged        = { fg = colors.pastel_green },
        NvimTreeGitMerge         = { fg = colors.pastel_orange },
        NvimTreeGitRenamed       = { fg = colors.pastel_purple },
        NvimTreeGitNew           = { fg = colors.pastel_green },
        NvimTreeGitDeleted       = { fg = colors.pastel_red },

        -- Telescope
        TelescopeNormal          = { fg = colors.fg, bg = colors.bg_dark },
        TelescopeBorder          = { fg = colors.border, bg = colors.bg_dark },
        TelescopePromptBorder    = { fg = colors.border, bg = colors.bg_dark },
        TelescopeResultsBorder   = { fg = colors.border, bg = colors.bg_dark },
        TelescopePreviewBorder   = { fg = colors.border, bg = colors.bg_dark },
        TelescopePromptNormal    = { fg = colors.fg, bg = colors.bg_dark },
        TelescopeResultsNormal   = { fg = colors.fg, bg = colors.bg_dark },
        TelescopePreviewNormal   = { fg = colors.fg, bg = colors.bg_dark },
        TelescopePromptTitle     = { fg = colors.bg_dark, bg = colors.purple },
        TelescopeResultsTitle    = { fg = colors.bg_dark, bg = colors.blue },
        TelescopePreviewTitle    = { fg = colors.bg_dark, bg = colors.green },
        TelescopeSelection       = { fg = colors.fg, bg = colors.bg_light },
        TelescopeSelectionCaret  = { fg = colors.purple, bg = colors.bg_light },
        TelescopeMultiSelection  = { fg = colors.fg, bg = colors.bg_lighter },
        TelescopeMatching        = { fg = colors.yellow, bold = true },

        -- Gitsigns
        GitSignsAdd              = { fg = colors.green },
        GitSignsChange           = { fg = colors.yellow },
        GitSignsDelete           = { fg = colors.red },
        GitSignsCurrentLineBlame = { fg = colors.gray },

        -- Cmp (completion)
        CmpItemAbbr              = { fg = colors.fg },
        CmpItemAbbrDeprecated    = { fg = colors.gray, strikethrough = true },
        CmpItemAbbrMatch         = { fg = colors.blue, bold = true },
        CmpItemAbbrMatchFuzzy    = { fg = colors.blue, underline = true },
        CmpItemKind              = { fg = colors.purple },
        CmpItemMenu              = { fg = colors.comment },
        CmpItemKindText          = { fg = colors.fg },
        CmpItemKindMethod        = { fg = colors.purple },
        CmpItemKindFunction      = { fg = colors.purple },
        CmpItemKindConstructor   = { fg = colors.blue },
        CmpItemKindField         = { fg = colors.blue },
        CmpItemKindVariable      = { fg = colors.orange },
        CmpItemKindClass         = { fg = colors.blue },
        CmpItemKindInterface     = { fg = colors.green },
        CmpItemKindModule        = { fg = colors.yellow },
        CmpItemKindProperty      = { fg = colors.blue },
        CmpItemKindUnit          = { fg = colors.green },
        CmpItemKindValue         = { fg = colors.orange },
        CmpItemKindEnum          = { fg = colors.blue },
        CmpItemKindKeyword       = { fg = colors.purple },
        CmpItemKindSnippet       = { fg = colors.green },
        CmpItemKindColor         = { fg = colors.orange },
        CmpItemKindFile          = { fg = colors.blue },
        CmpItemKindReference     = { fg = colors.blue },
        CmpItemKindFolder        = { fg = colors.blue },
        CmpItemKindEnumMember    = { fg = colors.green },
        CmpItemKindConstant      = { fg = colors.orange },
        CmpItemKindStruct        = { fg = colors.blue },
        CmpItemKindEvent         = { fg = colors.orange },
        CmpItemKindOperator      = { fg = colors.orange },
        CmpItemKindTypeParameter = { fg = colors.blue },

        -- Indent Blankline
        IndentBlanklineChar      = { fg = colors.bg_lighter },
        IndentBlanklineContextChar = { fg = colors.gray },

        -- WhichKey
        WhichKey                 = { fg = colors.purple },
        WhichKeyGroup            = { fg = colors.blue },
        WhichKeyDesc             = { fg = colors.green },
        WhichKeySeparator        = { fg = colors.gray },
        WhichKeyFloat            = { bg = colors.bg_dark },
        WhichKeyValue            = { fg = colors.gray },

        -- Hop
        HopNextKey               = { fg = colors.red, bold = true },
        HopNextKey1              = { fg = colors.blue, bold = true },
        HopNextKey2              = { fg = colors.green },
        HopUnmatched             = { fg = colors.gray },

        -- Leap
        LeapMatch                = { fg = colors.green, bold = true },
        LeapLabelPrimary         = { fg = colors.red, bold = true },
        LeapLabelSecondary       = { fg = colors.blue, bold = true },

        -- LspSaga
        LspSagaCodeActionTitle   = { fg = colors.green, bold = true },
        LspSagaCodeActionBorder  = { fg = colors.border },
        LspSagaCodeActionContent = { fg = colors.fg },
        LspSagaLightBulb         = { fg = colors.yellow },
        LspSagaFinderSelection   = { fg = colors.green },
        LspSagaDefPreviewBorder  = { fg = colors.border },
        LspSagaHoverBorder       = { fg = colors.border },
        LspSagaRenameBorder      = { fg = colors.border },
        LspSagaDiagnosticBorder  = { fg = colors.border },
        LspSagaDiagnosticHeader  = { fg = colors.blue, bold = true },
        LspInlayHint= { fg = "#A0A0A0", italic = true },

        -- Bufferline
        BufferLineFill           = { bg = colors.bg_dark },
        BufferLineBackground     = { fg = colors.gray, bg = colors.bg_dark },
        BufferLineBufferVisible  = { fg = colors.gray, bg = colors.bg },
        BufferLineBuffer         = { fg = colors.gray, bg = colors.bg_dark },
        BufferLineCloseButton    = { fg = colors.gray, bg = colors.bg_dark },
        BufferLineCloseButtonVisible = { fg = colors.gray, bg = colors.bg },
        BufferLineCloseButtonSelected = { fg = colors.red, bg = colors.bg },
        BufferLineSeparator      = { fg = colors.bg_dark, bg = colors.bg_dark },
        BufferLineSeparatorVisible = { fg = colors.bg, bg = colors.bg },
        BufferLineSeparatorSelected = { fg = colors.bg, bg = colors.bg },
        BufferLineIndicatorSelected = { fg = colors.blue, bg = colors.bg },
        BufferLineModified       = { fg = colors.yellow, bg = colors.bg_dark },
        BufferLineModifiedVisible = { fg = colors.yellow, bg = colors.bg },
        BufferLineModifiedSelected = { fg = colors.yellow, bg = colors.bg },
        BufferLineError          = { fg = colors.red, bg = colors.bg_dark },
        BufferLineErrorVisible   = { fg = colors.red, bg = colors.bg },
        BufferLineErrorSelected  = { fg = colors.red, bg = colors.bg },
        BufferLineWarning        = { fg = colors.orange, bg = colors.bg_dark },
        BufferLineWarningVisible = { fg = colors.orange, bg = colors.bg },
        BufferLineWarningSelected = { fg = colors.orange, bg = colors.bg },

        -- Treesitter Rainbow
        rainbowcol1 = { fg = colors.blue },
        rainbowcol2 = { fg = colors.orange },
        rainbowcol3 = { fg = colors.green },
        rainbowcol4 = { fg = colors.red },
        rainbowcol5 = { fg = colors.purple },
        rainbowcol6 = { fg = colors.yellow },
        rainbowcol7 = { fg = colors.blue },

        -- Neogit
        NeogitBranch             = { fg = colors.blue, bold = true },
        NeogitRemote             = { fg = colors.purple },
        NeogitHunkHeader         = { fg = colors.fg, bg = colors.bg_light },
        NeogitHunkHeaderHighlight = { fg = colors.blue, bg = colors.bg_light, bold = true },
        NeogitDiffContext        = { fg = colors.fg, bg = colors.bg },
        NeogitDiffContextHighlight = { fg = colors.fg, bg = colors.bg_light },
        NeogitDiffAdd            = { fg = colors.green },
        NeogitDiffDelete         = { fg = colors.red },

        -- Dashboard
        DashboardHeader          = { fg = colors.blue },
        DashboardCenter          = { fg = colors.purple },
        DashboardShortcut        = { fg = colors.orange },
        DashboardFooter          = { fg = colors.gray, italic = true },

        -- Notify
        NotifyERRORBorder        = { fg = colors.red },
        NotifyERRORIcon          = { fg = colors.red },
        NotifyERRORTitle         = { fg = colors.red, bold = true },
        NotifyWARNBorder         = { fg = colors.yellow },
        NotifyWARNIcon           = { fg = colors.yellow },
        NotifyWARNTitle          = { fg = colors.yellow, bold = true },
        NotifyINFOBorder         = { fg = colors.blue },
        NotifyINFOIcon           = { fg = colors.blue },
        NotifyINFOTitle          = { fg = colors.blue, bold = true },
        NotifyDEBUGBorder        = { fg = colors.gray },
        NotifyDEBUGIcon          = { fg = colors.gray },
        NotifyDEBUGTitle         = { fg = colors.gray, bold = true },
        NotifyTRACEBorder        = { fg = colors.purple },
        NotifyTRACEIcon          = { fg = colors.purple },
        NotifyTRACETitle         = { fg = colors.purple, bold = true },

        -- Trouble
        TroubleNormal           = { fg = colors.fg, bg = colors.bg_dark },
        TroubleText             = { fg = colors.fg },
        TroubleCount            = { fg = colors.purple, bg = colors.bg_dark },
        TroubleLocation         = { fg = colors.blue, bg = colors.bg_dark },
        TroubleFile             = { fg = colors.green, bold = true },
        TroubleIndent           = { fg = colors.gray },
        TroubleFoldIcon         = { fg = colors.gray },
        TroubleSignError        = { fg = colors.red },
        TroubleSignWarning      = { fg = colors.orange },
        TroubleSignInformation  = { fg = colors.blue },
        TroubleSignHint         = { fg = colors.green },

        -- Barbar
        BufferCurrent           = { fg = colors.fg, bg = colors.bg },
        BufferCurrentIndex      = { fg = colors.blue, bg = colors.bg },
        BufferCurrentMod        = { fg = colors.yellow, bg = colors.bg },
        BufferCurrentSign       = { fg = colors.blue, bg = colors.bg },
        BufferCurrentTarget     = { fg = colors.red, bg = colors.bg, bold = true },
        BufferVisible           = { fg = colors.fg, bg = colors.bg_dark },
        BufferVisibleIndex      = { fg = colors.blue, bg = colors.bg_dark },
        BufferVisibleMod        = { fg = colors.yellow, bg = colors.bg_dark },
        BufferVisibleSign       = { fg = colors.gray, bg = colors.bg_dark },
        BufferVisibleTarget     = { fg = colors.red, bg = colors.bg_dark, bold = true },
        BufferInactive          = { fg = colors.gray, bg = colors.bg_dark },
        BufferInactiveIndex     = { fg = colors.gray, bg = colors.bg_dark },
        BufferInactiveMod       = { fg = colors.yellow, bg = colors.bg_dark },
        BufferInactiveSign      = { fg = colors.gray, bg = colors.bg_dark },
        BufferInactiveTarget    = { fg = colors.red, bg = colors.bg_dark, bold = true },

        -- Symbols Outline
        FocusedSymbol           = { fg = colors.blue, bg = colors.bg_light, bold = true },
        SymbolsOutlineConnector = { fg = colors.gray },

        -- Noice
        NoiceCmdline            = { fg = colors.fg, bg = colors.bg_dark },
        NoiceCmdlineIcon        = { fg = colors.blue },
        NoiceCmdlineIconSearch  = { fg = colors.yellow },
        NoiceConfirmBorder      = { fg = colors.border },
        NoicePopupmenuBorder    = { fg = colors.border },

        -- Mini.nvim
        MiniIndentscopeSymbol   = { fg = colors.gray },
        MiniJump2dSpot          = { fg = colors.red, bold = true },
        MiniStarterCurrent      = { fg = colors.blue },
        MiniStarterFooter       = { fg = colors.gray, italic = true },
        MiniStarterHeader       = { fg = colors.blue },
        MiniStarterInactive     = { fg = colors.gray },
        MiniStarterItem         = { fg = colors.fg },
        MiniStarterItemBullet   = { fg = colors.border },
        MiniStarterItemPrefix   = { fg = colors.yellow },
        MiniStarterSection      = { fg = colors.purple },
        MiniStarterQuery        = { fg = colors.green },
        MiniSurround            = { bg = colors.orange, fg = colors.bg },
        MiniTablineCurrent      = { fg = colors.fg, bg = colors.bg },
        MiniTablineFill         = { bg = colors.bg_dark },
        MiniTablineHidden       = { fg = colors.gray, bg = colors.bg_dark },
        MiniTablineModifiedCurrent = { fg = colors.yellow, bg = colors.bg },
        MiniTablineModifiedHidden = { fg = colors.yellow, bg = colors.bg_dark },
        MiniTablineModifiedVisible = { fg = colors.yellow, bg = colors.bg_dark },
        MiniTablineVisible      = { fg = colors.fg, bg = colors.bg_dark },
        MiniTestEmphasis        = { bold = true },
        MiniTestFail            = { fg = colors.red, bold = true },
        MiniTestPass            = { fg = colors.green, bold = true },
        MiniTrailspace          = { bg = colors.red },

        -- Alpha
        AlphaHeader             = { fg = colors.blue },
        AlphaButtons            = { fg = colors.purple },
        AlphaShortcut           = { fg = colors.orange },
        AlphaFooter             = { fg = colors.gray, italic = true },

        -- Tree-sitter highlighting (Note: the ones without comment are from AI)
        ["@attribute"] = { fg = colors.pastel_orange },          -- attribute annotations (e.g. Python decorators, Rust lifetimes)
        ["@attribute.builtin"] = {fg = colors.pastel_purple},  -- builtin annotations (e.g. `@property` in Python)
        ["@boolean"] = { link = "Boolean" },                -- boolean literals
        ["@character"] = { link = "Character" },              -- character literals
        ["@character.special"] = { fg = colors.pastel_brown },      -- special characters (e.g. wildcards)
        ["@comment"] = { link = "Comment" },               -- line and block comments
        ["@comment.documentation"] = {link = "Comment"}, -- comments documenting code
        ["@comment.error"] = {link = "Comment"},         -- error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
        ["@comment.note"] = {link = "Comment"},          -- note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
        ["@comment.todo"] = {fg = colors.pastel_blue},          -- todo-type comments (e.g. `TODO`, `WIP`)
        ["@comment.warning"] = {link = "Comment"},       -- warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
        ["@conceal"] = {}, -- captures that are only meant to be concealed
        ["@conditional"]     = { link = "Conditional" },
        ["@constant"] = { link = "Constant" },          -- constant identifiers
        ["@constant.builtin"] = { fg = colors.pastel_emerald },  -- built-in constant values
        ["@constant.macro"] = { fg = colors.pastel_orange },    -- constants defined by the preprocessor
        ["@constructor"] = { fg = colors.pastel_blue },          -- constructor calls and definitions
        ["@debug"]           = { link = "Debug" },
        ["@define"]          = { link = "Define" },
        ["@diff.delta"] = {bg=colors.pastel_orange},      -- changed text (for diff files)
        ["@diff.minus"] = {bg=colors.pastel_red},      -- deleted text (for diff files)
        ["@diff.plus"] = {bg=colors.pastel_green},       -- added text (for diff files)
        ["@error"]           = { link = "Error" },
        ["@exception"]       = { link = "Exception" },
        ["@field"]           = { fg = colors.pastel_blue },
        ["@float"]           = { link = "Float" },
        ["@function"] = { link = "Function" },             -- function definitions
        ["@function.builtin"] = { fg = colors.pastel_emerald},     -- built-in functions
        ["@function.call"] = { fg = colors.pastel_mint},        -- function calls
        ["@function.macro"] = { fg = colors.pastel_orange },       -- preprocessor macros
        ["@function.method"] = {},      -- method definitions
        ["@function.method.call"] = {}, -- method calls
        ["@include"]         = { link = "Include" },
        ["@indent.align"] = {},       -- behaves like python aligned/hanging indent
        ["@indent.auto"] = {},        -- behaves like 'autoindent' buffer option
        ["@indent.begin"] = {},       -- indent children when matching this node
        ["@indent.branch"] = {},      -- dedent itself when matching this node
        ["@indent.dedent"] = {},      -- dedent children when matching this node
        ["@indent.end"] = {},         -- marks the end of indented block
        ["@indent.ignore"] = {},      -- do not indent in this node
        ["@indent.zero"] = {},        -- sets this node at position 0 (no indent)
        ["@keyword"] = { link = "Keyword" },                   -- keywords not fitting into specific categories
        ["@keyword.conditional"] = {},         -- keywords related to conditionals (e.g. `if` / `else`)
        ["@keyword.conditional.ternary"] = {}, -- ternary operator (e.g. `?` / `:`)
        ["@keyword.coroutine"] = {},         -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
        ["@keyword.debug"] = {},             -- keywords related to debugging
        ["@keyword.directive"] = {},         -- various preprocessor directives & shebangs
        ["@keyword.directive.define"] = {fg = colors.pastel_orange},  -- preprocessor definition directives
        ["@keyword.exception"] = {fg = colors.pastel_purple},         -- keywords related to exceptions (e.g. `throw` / `catch`)
        ["@keyword.function"] = { fg = colors.pastel_purple },          -- keywords that define a function (e.g. `func` in Go, `def` in Python)
        ["@keyword.import"] = {fg = colors.pastel_purple},            -- keywords for including or exporting modules (e.g. `import` / `from` in Python)
        ["@keyword.modifier"] = {fg = colors.pastel_purple},          -- keywords modifying other constructs (e.g. `const`, `static`, `public`)
        ["@keyword.operator"] = { fg = colors.pastel_purple },          -- operators that are English words (e.g. `and` / `or`)
        ["@keyword.repeat"] = {fg = colors.pastel_purple},            -- keywords related to loops (e.g. `for` / `while`)
        ["@keyword.return"] = { fg = colors.pastel_purple },            -- keywords like `return` and `yield`
        ["@keyword.type"] = {fg = colors.pastel_purple},              -- keywords describing namespaces and composite types (e.g. `struct`, `enum`)
        ["@label"] = { link = "Label" },             -- GOTO and other labels (e.g. `label:` in C), including heredoc labels
        ["@local.definition"] = {},            -- various definitions
        ["@local.definition.associated"] = {}, -- the associated type of a variable
        ["@local.definition.constant"] = {},   -- constants
        ["@local.definition.enum"] = {},       -- enumerations
        ["@local.definition.field"] = {},      -- fields or properties
        ["@local.definition.function"] = {},   -- functions
        ["@local.definition.import"] = {},     -- imported names
        ["@local.definition.macro"] = {},      -- preprocessor macros
        ["@local.definition.method"] = {},     -- methods
        ["@local.definition.namespace"] = {},  -- modules or namespaces
        ["@local.definition.parameter"] = {},  -- parameters
        ["@local.definition.type"] = {},       -- types or classes
        ["@local.definition.var"] = {},        -- variables
        ["@local.reference"] = {},             -- identifier reference
        ["@local.scope"] = {},                 -- scope block
        ["@markup.heading"] = {},        -- headings, titles (including markers)
        ["@markup.heading.1"] = {}, -- top-level heading
        ["@markup.heading.2"] = {}, -- section heading
        ["@markup.heading.3"] = {}, -- subsection heading
        ["@markup.heading.4"] = {}, -- and so on
        ["@markup.heading.5"] = {}, -- and so forth
        ["@markup.heading.6"] = {}, -- six levels ought to be enough for anybody
        ["@markup.italic"] = {},         -- italic text
        ["@markup.link"] = {},           -- text references, footnotes, citations, etc.
        ["@markup.link.label"] = {},     -- link, reference descriptions
        ["@markup.link.url"] = {},       -- URL-style links
        ["@markup.list"] = {},           -- list markers
        ["@markup.list.checked"] = {},   -- checked todo-style list markers
        ["@markup.list.unchecked"] = {}, -- unchecked todo-style list markers
        ["@markup.math"] = {},           -- math environments (e.g. `$ ... $` in LaTeX)
        ["@markup.quote"] = {},          -- block quotes
        ["@markup.raw"] = {},            -- literal or verbatim text (e.g. inline code)
        ["@markup.raw.block"] = {},      -- literal or verbatim text as a stand-alone block (use priority 90 for blocks with injections)
        ["@markup.strikethrough"] = {},  -- struck-through text
        ["@markup.strong"] = {},         -- bold text
        ["@markup.underline"] = {},      -- underlined text (only for literal underline markup!)
        ["@method"]          = { fg = colors.pastel_teal},
        ["@method.call"]     = { fg = colors.pastel_teal},
        ["@module"] = { fg = colors.pastel_teal },            -- modules or namespaces
        ["@module.builtin"] = { fg = colors.pastel_teal },    -- built-in modules or namespaces
        ["@namespace"]       = { fg = colors.pastel_teal },
        ["@none"] = { bg = colors.none, fg = colors.none },    -- completely disable the highlight
        ["@number"] = { link = "Number" },                 -- numeric literals
        ["@number.float"] = {},           -- floating-point number literals
        ["@operator"] = { link = "Operator" },             -- symbolic operators (e.g. `+` / `*`)
        ["@parameter"]       = { fg = colors.pastel_yellow},
        ["@preproc"]         = { link = "PreProc" },
        ["@property"] = { fg = colors.pastel_blue },           -- the key in key/value pairs
        ["@punctuation.bracket"] = { fg = colors.gray },   -- brackets (e.g. `()` / `{}` / `[]`)
        ["@punctuation.delimiter"] = { fg = colors.gray }, -- delimiters (e.g. `;` / `.` / `,`)
        ["@punctuation.special"] = { fg = colors.pastel_orange },   -- special symbols (e.g. `{}` in string interpolation)
        ["@repeat"]          = { link = "Repeat" },
        ["@storageclass"]    = { link = "StorageClass" },
        ["@string"] = { link = "String" },                 -- string literals
        ["@string.documentation"] = {},   -- string documenting code (e.g. Python docstrings)
        ["@string.escape"] = { fg = colors.pastel_orange },          -- escape sequences
        ["@string.regex"]    = { fg = colors.pastel_orange },
        ["@string.regexp"] = {},          -- regular expressions
        ["@string.special"] = {},         -- other special strings (e.g. dates)
        ["@string.special.path"] = {},    -- filenames
        ["@string.special.symbol"] = {},  -- symbols or atoms
        ["@string.special.url"] = {},     -- URIs (e.g. hyperlinks)
        ["@symbol"]          = { fg = colors.pastel_orange },
        ["@tag"] = { link = "Tag" },           -- XML-style tag names (and similar)
        ["@tag.attribute"] = { fg = colors.pastel_blue }, -- XML-style tag attributes
        ["@tag.builtin"] = {},   -- builtin tag names (e.g. HTML5 tags)
        ["@tag.delimiter"] = { fg = colors.pastel_gray }, -- XML-style tag delimiters
        ["@text"]            = { fg = colors.fg },
        ["@text.danger"]     = { fg = colors.pastel_red, bold = true },
        ["@text.diff.add"]   = { link = "DiffAdd" },
        ["@text.diff.delete"] = { link = "DiffDelete" },
        ["@text.literal"]    = { fg = colors.pastel_green },
        ["@text.math"]       = { fg = colors.pastel_blue },
        ["@text.note"]       = { fg = colors.pastel_blue, bold = true },
        ["@text.reference"]  = { fg = colors.pastel_blue, underline = true },
        ["@text.title"]      = { link = "Title" },
        ["@text.todo"]       = { link = "Todo" },
        ["@text.uri"]        = { fg = colors.pastel_blue, underline = true },
        ["@text.warning"]    = { fg = colors.pastel_orange, bold = true },
        ["@type"] = { link = "Type" },             -- type or class definitions and annotations
        ["@type.builtin"] = { fg = colors.pastel_purple },     -- built-in types
        ["@type.definition"] = { fg = colors.pastel_teal },  -- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
        ["@type.qualifier"]  = { fg = colors.pastel_purple },
        ["@variable"] = { fg = colors.fg },                    -- various variable names
        ["@variable.builtin"] = { fg = colors.pastel_brown },            -- built-in variable names (e.g. `this`)
        ["@variable.member"] = {fg= colors.pastel_indigo},             -- object and struct fields
        ["@variable.parameter"] = {link="@parameter"},          -- parameters of a function
        ["@variable.parameter.builtin"] = {fg = colors.pastel_lavender},  -- special parameters (e.g. `_`, `it`)

        -- Semantic tokens highlighting (for LSP semantic tokens)
        ["@lsp.type.class"] = { link = "Structure" },
        ["@lsp.type.comment"] = { link = "Comment" },
        ["@lsp.type.decorator"] = { fg = colors.pastel_orange },
        ["@lsp.type.enum"] = { link = "Type" },
        ["@lsp.type.enumMember"] = { fg = colors.pastel_green },
        ["@lsp.type.function"] = { link = "Function" },
        ["@lsp.type.interface"] = { fg = colors.pastel_blue, italic = true },
        ["@lsp.type.macro"] = { link = "Macro" },
        ["@lsp.type.method"] = { link = "@method" },
        ["@lsp.type.namespace"] = { link = "@namespace" },
        ["@lsp.type.parameter"] = { link = "@parameter" },
        ["@lsp.type.property"] = { link = "@property" },
        ["@lsp.type.struct"] = { link = "Structure" },
        ["@lsp.type.type"] = { link = "Type" },
        ["@lsp.type.typeParameter"] = { fg = colors.pastel_orange, italic = true },
        ["@lsp.type.variable"] = { link = "@variable" },
        ["@lsp.type.keyword"] = { link = "Keyword" },
        ["@lsp.type.string"] = { link = "String" },
        ["@lsp.type.number"] = { link = "Number" },
        ["@lsp.type.regexp"] = { fg = colors.pastel_orange },
        ["@lsp.type.operator"] = { link = "Operator" },
        ["@lsp.type.modifier"] = { fg = colors.pastel_purple },

        -- LSP Semantic modifiers
        ["@lsp.mod.deprecated"] = { strikethrough = true },
        ["@lsp.mod.readonly"] = { italic = true,bold = true },
        ["@lsp.mod.async"] = { italic = true },
        ["@lsp.mod.mutable"] = { italic = true, bold= true},
        ["@lsp.mod.static"] = { fg = colors.pastel_olive},
        ["@lsp.mod.abstract"] = { italic = true },
        ["@lsp.typemod.variable.readonly"] = { italic = true },
        ["@lsp.typemod.variable.defaultLibrary"] = { fg = colors.pastel_red },
        ["@lsp.typemod.variable.static"] = { fg = colors.pastel_indigo },
        ["@lsp.typemod.function.defaultLibrary"] = { fg = colors.pastel_emerald },

        -- LSP Inlay Hints
        ["@lsp.typemod.inlayHint.parameter"] = { fg = colors.comment, italic = true, bg = colors.bg_subtle },
        ["@lsp.typemod.inlayHint.type"] = { fg = colors.comment, italic = true, bg = colors.bg_subtle },

    }

    -- Set highlight groups
    for group, styles in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, styles)
    end
end

-- Return the colorscheme module
return M

