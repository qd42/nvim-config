require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Simple plugins can be specified as strings
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'kana/vim-submode'
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
  }
-- nvim-cmp completion sources
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use 'SirVer/ultisnips'
    use 'mfussenegger/nvim-dap'

    use 'mhinz/vim-startify'

    use 'BurntSushi/ripgrep'
    use 'nvim-lua/plenary.nvim'
    use {
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim' }
    }
    use 'nvim-telescope/telescope-dap.nvim'
    use 'mfussenegger/nvim-dap-python'
    use 'rcarriga/nvim-dap-ui'

    use 'shaunsingh/nord.nvim'

    use 'feline-nvim/feline.nvim'
    --    use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
    -- on windows: 'powershell ./install.ps1'
    -- use 'ellisonleao/gruvbox.nvim'
end)

vim.o.termguicolors = true

require('feline').setup()

require('config.telescope')
require('config.lsp')
require('config.dap')
require('config.cmp')
require('config.colorscheme')
