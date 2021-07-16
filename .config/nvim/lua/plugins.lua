local execute = vim.api.nvim_command
local fn = vim.fn

execute 'packadd packer.nvim'

return require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  -- status line
  use 'kyazdani42/nvim-web-devicons'
  use 'famiu/feline.nvim'
  require('feline').setup()
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  require('gitsigns').setup()

  -- smooth scrolling
  use 'psliwka/vim-smoothie'

  -- File tree
  use {
    'kyazdani42/nvim-tree.lua',
    commit = 'fd7f60e242205ea9efc9649101c81a07d5f458bb' -- Lock to this commit until it's fixed
  }

  use 'akinsho/nvim-toggleterm.lua'
  require 'toggleterm'.setup {
    direction = 'horizontal'
  }

  -- comment bindings
  use 'b3nj5m1n/kommentary'
  require('kommentary.config').configure_language('default', {
    prefer_single_line_comments = true
  })

  -- parens autoclosing
  use 'Raimondi/delimitMate'
  -- Mark annotator
  use 'kshenoy/vim-signature'

  -- Better syntax highlighting
  use 'nvim-treesitter/nvim-treesitter'

  -- One Dark color theme
  use 'navarasu/onedark.nvim'

  -- LSP config
  use 'neovim/nvim-lspconfig'
  -- Autocompletion
  use 'hrsh7th/nvim-compe'
  use 'ray-x/lsp_signature.nvim'
  -- Formatting
  use 'mhartington/formatter.nvim'

  -- Startup screen
  use 'mhinz/vim-startify'

  -- Better session handling
  use {
    'xolox/vim-session',
    requires = {{'xolox/vim-misc'}}
  }

  -- Git helpers
  use 'tpope/vim-fugitive'
  use 'mbbill/undotree'

  -- CMake wrapepr
  use 'vhdirk/vim-cmake'

  -- clang-format support
  use 'rhysd/vim-clang-format'

  -- Vim list navigation
  use 'tpope/vim-unimpaired'

  -- Auto-indentation detection
  use 'tpope/vim-sleuth'

  -- Fuzzy finder
  use 'junegunn/fzf.vim'
  use 'junegunn/fzf'
  -- :bufd is broken otherwise
  use 'famiu/bufdelete.nvim'

  use {
    'folke/which-key.nvim',
  }

  use {'lukas-reineke/indent-blankline.nvim'}
end)
