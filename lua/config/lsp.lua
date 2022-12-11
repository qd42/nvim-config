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

local lspsaga = require('lspsaga')
lspsaga.init_lsp_saga()
