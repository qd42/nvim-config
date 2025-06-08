-- Autocommands configuration
-- This file sets up automatic commands that respond to various Vim events

local augroup = vim.api.nvim_create_augroup -- Function to create autocommand groups
local autocmd = vim.api.nvim_create_autocmd -- Function to create autocommands

-- Highlight on Yank
-- Briefly highlight text when it's yanked (copied)
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- Nord Theme Integration
-- Autocommands specific to the Nord color scheme
augroup("NordTheme", { clear = true })
autocmd("ColorScheme", {
  group = "NordTheme",
  callback = function()
    require("nord.util").onColorScheme() -- Apply Nord theme utilities
  end,
})

-- Terminal window highlighting
autocmd("TermOpen", {
  group = "NordTheme",
  pattern = "*",
  command = "setlocal winhighlight=Normal:black,NormalNC:NormalNC,SignColumn:NormalFloat"
})

-- Special file type highlighting (packer and quickfix)
autocmd("FileType", {
  group = "NordTheme",
  pattern = { "packer", "qf" },
  command = "setlocal winhighlight=Normal:black,NormalNC:NormalNC,SignColumn:NormalFloat"
})

-- Auto-trim Trailing Whitespace
-- Remove trailing whitespace on save for cleaner code
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "TrimWhitespace",
  pattern = "*",
  command = "%s/\\s\\+$//e" -- Remove trailing whitespace
})

-- Windows-specific Enhanced Syntax Highlighting
-- Fallback syntax highlighting for Windows where TreeSitter might not work
if vim.fn.has("win32") == 1 then
  augroup("WindowsSyntax", { clear = true })
  
  -- Enhanced syntax for common file types
  autocmd("FileType", {
    group = "WindowsSyntax",
    pattern = { "lua", "vim", "json", "yaml", "markdown", "html", "css", "javascript", "typescript", "python", "c", "cpp", "rust" },
    callback = function()
      vim.cmd("syntax enable")
      vim.cmd("syntax sync minlines=200") -- Sync syntax highlighting
      vim.wo.foldmethod = "syntax"        -- Use syntax-based folding
      vim.wo.foldlevel = 99              -- Start with all folds open
      vim.bo.smartindent = true          -- Enable smart indentation
      vim.bo.autoindent = true           -- Enable auto indentation
    end,
  })
  
  -- Enhanced Lua syntax highlighting
  autocmd("FileType", {
    group = "WindowsSyntax",
    pattern = "lua",
    callback = function()
      vim.cmd([[
        " Define Lua keywords and constructs
        syntax keyword luaFunction function end local return
        syntax keyword luaConditional if then else elseif
        syntax keyword luaRepeat for while repeat until do
        syntax keyword luaOperator and or not
        syntax keyword luaConstant nil true false
        syntax keyword luaBuiltin print pairs ipairs next type getmetatable setmetatable
        syntax keyword luaBuiltin require module package table string math io os debug
        
        " Function calls pattern
        syntax match luaFunction "\<\w\+\>\s*("me=e-1
        
        " String patterns
        syntax region luaString start='"' end='"' skip='\\"'
        syntax region luaString start="'" end="'" skip="\\'"
        syntax region luaString start='\[\[' end='\]\]'
        
        " Numbers
        syntax match luaNumber '\<\d\+\>'
        syntax match luaNumber '\<\d\+\.\d*\>'
        
        " Comments
        syntax match luaComment '--.*$'
        
        " Link to highlight groups
        hi def link luaFunction Function
        hi def link luaConditional Conditional
        hi def link luaRepeat Repeat
        hi def link luaOperator Operator
        hi def link luaConstant Constant
        hi def link luaBuiltin Special
        hi def link luaString String
        hi def link luaNumber Number
        hi def link luaComment Comment
      ]])
    end,
  })
  
  -- Enhanced C/C++ syntax highlighting
  autocmd("FileType", {
    group = "WindowsSyntax",
    pattern = { "c", "cpp" },
    callback = function()
      vim.cmd([[
        " C/C++ data types
        syntax keyword cType int char float double void long short unsigned signed
        syntax keyword cType bool size_t ptrdiff_t wchar_t
        
        " Control flow statements
        syntax keyword cStatement return break continue goto
        syntax keyword cConditional if else switch case default
        syntax keyword cRepeat for while do
        
        " Storage classes and qualifiers
        syntax keyword cStorageClass static extern auto register const volatile inline
        
        " Preprocessor directives
        syntax keyword cInclude #include #define #ifdef #ifndef #endif #if #else #elif
        
        " C++ specific types and keywords
        syntax keyword cppType string vector map set list deque stack queue
        syntax keyword cppKeyword class struct namespace using template typename
        syntax keyword cppKeyword public private protected virtual override final
        
        " String and character literals
        syntax region cString start='"' end='"' skip='\\"'
        syntax region cChar start="'" end="'" skip="\\'"
        
        " Numbers (decimal and hexadecimal)
        syntax match cNumber '\<\d\+\>'
        syntax match cNumber '\<0x\x\+\>'
        
        " Comments
        syntax match cComment '//.*$'
        syntax region cComment start='/\*' end='\*/'
        
        " Link to highlight groups
        hi def link cType Type
        hi def link cStatement Statement
        hi def link cConditional Conditional
        hi def link cRepeat Repeat
        hi def link cStorageClass StorageClass
        hi def link cInclude PreProc
        hi def link cppType Type
        hi def link cppKeyword Keyword
        hi def link cString String
        hi def link cChar Character
        hi def link cNumber Number
        hi def link cComment Comment
      ]])
    end,
  })
  
  -- Enhanced Python syntax highlighting
  autocmd("FileType", {
    group = "WindowsSyntax",
    pattern = "python",
    callback = function()
      vim.cmd([[
        " Python keywords
        syntax keyword pythonKeyword def class if elif else try except finally
        syntax keyword pythonKeyword for while break continue pass return yield
        syntax keyword pythonKeyword import from as with lambda global nonlocal
        syntax keyword pythonKeyword and or not in is
        
        " Python constants
        syntax keyword pythonConstant True False None
        
        " Built-in functions
        syntax keyword pythonBuiltin print len range str int float list dict set tuple
        syntax keyword pythonBuiltin open file input raw_input type isinstance
        
        " String literals (single, double, triple quotes)
        syntax region pythonString start='"' end='"' skip='\\"'
        syntax region pythonString start="'" end="'" skip="\\'"
        syntax region pythonString start='"""' end='"""'
        syntax region pythonString start="'''" end="'''"
        
        " Numbers
        syntax match pythonNumber '\<\d\+\>'
        syntax match pythonNumber '\<\d\+\.\d*\>'
        
        " Comments
        syntax match pythonComment '#.*$'
        
        " Link to highlight groups
        hi def link pythonKeyword Keyword
        hi def link pythonConstant Constant
        hi def link pythonBuiltin Special
        hi def link pythonString String
        hi def link pythonNumber Number
        hi def link pythonComment Comment
      ]])
    end,
  })
  
  -- Enhanced JavaScript/TypeScript syntax highlighting
  autocmd("FileType", {
    group = "WindowsSyntax",
    pattern = { "javascript", "typescript" },
    callback = function()
      vim.cmd([[
        " JavaScript keywords
        syntax keyword jsKeyword function var let const if else for while do
        syntax keyword jsKeyword try catch finally throw return break continue
        syntax keyword jsKeyword class extends import export default async await
        syntax keyword jsKeyword typeof instanceof new delete void
        
        " JavaScript constants
        syntax keyword jsConstant true false null undefined
        
        " Built-in objects and functions
        syntax keyword jsBuiltin console window document Array Object String Number
        
        " String literals (including template literals)
        syntax region jsString start='"' end='"' skip='\\"'
        syntax region jsString start="'" end="'" skip="\\'"
        syntax region jsString start='`' end='`'
        
        " Numbers
        syntax match jsNumber '\<\d\+\>'
        syntax match jsNumber '\<\d\+\.\d*\>'
        
        " Comments
        syntax match jsComment '//.*$'
        syntax region jsComment start='/\*' end='\*/'
        
        " Link to highlight groups
        hi def link jsKeyword Keyword
        hi def link jsConstant Constant
        hi def link jsBuiltin Special
        hi def link jsString String
        hi def link jsNumber Number
        hi def link jsComment Comment
      ]])
    end,
  })
  
  -- Notify user about enhanced syntax highlighting on Windows
  autocmd("VimEnter", {
    group = "WindowsSyntax",
    once = true,
    callback = function()
      vim.notify(
        "TreeSitter disabled on Windows. Using enhanced built-in syntax highlighting for better stability.",
        vim.log.levels.INFO
      )
    end,
  })
end