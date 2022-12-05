require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use'kyazdani42/nvim-web-devicons'

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
    -- use 'quangnguyen30192/cmp-nvim-ultisnips'
    use 'f3fora/cmp-spell'
    -- use 'SirVer/ultisnips'
    use {'L3MON4D3/LuaSnip', tag = "v1.1.*"}
    use 'mfussenegger/nvim-dap'
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'

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
    use 'jbyuki/one-small-step-for-vimkind'
    use 'Pocco81/DAPInstall.nvim'
    use 'shaunsingh/nord.nvim'

    use 'cpea2506/one_monokai.nvim'
    use 'feline-nvim/feline.nvim'
    --    use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
    -- on windows: 'powershell ./install.ps1'
    -- use 'ellisonleao/gruvbox.nvim'

    use {
      'yamatsum/nvim-nonicons',
      requires = {'kyazdani42/nvim-web-devicons'}
    }
    use 'dstein64/vim-win'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function() require'nvim-tree'.setup {} end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
     }
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }
    use 'ggandor/leap.nvim'
    use {
        "akinsho/toggleterm.nvim", tag = '*',
        config = function()
            require("toggleterm").setup()
    end
    }
end)

vim.o.termguicolors = true

require('feline').setup()
require('Comment').setup()
require('leap').add_default_mappings()

require('config.telescope')
require('config.lsp')
require('config.dap')
require('config.cmp')
require('config.colorscheme')
require('config.devicons')
require('config.gitsigns')

vim.fn.sign_define('DiagnosticSignError', { text=' ', texthl='DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text=' ', texthl='DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignHint', { text=' ', texthl='DiagnosticSignHint' })
vim.fn.sign_define('DiagnosticSignInfo', { text=' ', texthl='DiagnosticSignInfo' })
