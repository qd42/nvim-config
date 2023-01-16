-- Use an on_attach function to only map the following keys after
-- the language server attaches to the current buffer
local on_attach  = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', "<leader>lD", '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', "<leader>lh", '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', "<leader>li", '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', "<leader>lH", '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', "<leader>l+", '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', "<leader>l-", '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', "<leader>l?", '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', "<leader>lt", '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', "<leader>lr", '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', "<leader>la", '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', "<leader>lR", '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', "<leader>ls", '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', "<leader>lj", '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', "<leader>lk", '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', "<leader>lS", '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', "<leader>lf", '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', "<leader>lc", '<cmd>ClangdSwitchSourceHeader<CR>', opts)

    -- Disable Autoformat I think that's been decommitioned
    -- client.resolved_capabilities.document_formatting = false
    -- client.resolved_capabilities.document_range_formatting = false
    end

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

  local lspconfig = require('lspconfig')
local servers = { 'clangd' , 'sumneko_lua', 'glslls' }
  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, lsp in ipairs(servers) do
    lspconfig[lsp]        .setup {
    capabilities = capabilities,
    on_attach = on_attach
    }
end

-- vim global is present in all nvim configs, this removes the warning
-- (technically it should only be in nvim configs, but that sounds tricky to enforce)
lspconfig.sumneko_lua.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

require('lspsaga').setup({
ui = {
    -- currently only round theme
    theme = 'round',
    -- border type can be single,double,rounded,solid,shadow.
    border = 'single',
    winblend = 0,
    expand = '',
    collapse = '',
    preview = ' ',
    code_action = '💡',
    diagnostic = '🐞',
    incoming = ' ',
    outgoing = ' ',
    colors = {
      --float window normal bakcground color
      normal_bg = '#1d1536',
      --title background color
      title_bg = '#afd700',
      red = '#e95678',
      magenta = '#b33076',
      orange = '#FF8700',
      yellow = '#f7bb3b',
      green = '#afd700',
      cyan = '#36d0e0',
      blue = '#61afef',
      purple = '#CBA6F7',
      white = '#d1d4cf',
      black = '#1c1c19',
    },
    kind = {},
  },
})

require('lspkind').init({
    -- DEPRECATED (use mode instead): enables text annotations
    --
    -- default: true
    -- with_text = true,

    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'sybol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})

local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
--        ...
        return vim_item
      end
    })
  }
}
-- Error = "", Warning = "", Hint = "", Information = ""

-- local lspsaga = require('lspsaga')
-- lspsaga.init_lsp_saga()

local cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = false, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  max_height = 12, -- max height of signature floating_window
  max_width = 80, -- max_width of signature floating_window
  noice = false, -- set to true if you using noice to render markdown
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position.
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

  close_timeout = 4000, -- close floating window after ms when laster parameter is entered
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
  move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}
-- recommended:
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

-- You can also do this inside lsp on_attach
-- note: on_attach deprecated
require'lsp_signature'.on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key

