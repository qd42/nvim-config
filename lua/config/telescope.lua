require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

--[[ telescope-dap
vim.api.nvim_set_key.map('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>',{})
vim.api.nvim_set_key.map('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>',{})
vim.api.nvim_set_key.map('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>',{})
vim.api.nvim_set_key.map('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>',{})
vim.api.nvim_set_key.map('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>',{})
]]


