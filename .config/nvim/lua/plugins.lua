local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

execute 'packadd packer.nvim'

return require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  -- icons
  use 'kyazdani42/nvim-web-devicons'

  -- status line
  use 'famiu/feline.nvim'
  require('feline').setup()
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  require('gitsigns').setup()

  -- smoth scrolling
  use 'psliwka/vim-smoothie'

  -- file tree
  use 'preservim/nerdtree'
  -- NERDTree icons
  use 'ryanoasis/vim-devicons'

  use 'akinsho/nvim-toggleterm.lua'
  require 'toggleterm'.setup {
    direction = 'horizontal'
  }

  -- comment keybindings
  use 'b3nj5m1n/kommentary'
  require('kommentary.config').configure_language('default', {
    prefer_single_line_comments = true
  })

  -- parens
  use 'Raimondi/delimitMate'

  -- register popup window
  -- use 'tversteeg/registers.nvim'

  -- clang-format support
  use 'rhysd/vim-clang-format'

  -- LSP config
  use 'neovim/nvim-lspconfig'

  -- Mark annotator
  use 'kshenoy/vim-signature'

  -- Better syntax highlighting
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  require'nvim-treesitter.configs'.setup {
    textobjects = {
      select = {
	enable = true,
	keymaps = {
	  -- You can use the capture groups defined in textobjects.scm
	  ["af"] = "@function.outer",
	  ["if"] = "@function.inner",
	  ["ac"] = "@class.outer",
	  ["ic"] = "@class.inner",

	  -- Or you can define your own textobjects like this
	  ["iF"] = {
	    python = "(function_definition) @function",
	    cpp = "(function_definition) @function",
	    c = "(function_definition) @function",
	    java = "(method_declaration) @function",
	  },
	},
      },
    },
  }


    require 'nvim-treesitter.configs'.setup {
      highlight = {
	enable = {'typescript', 'javascript', 'c'}
      },
      indent = {
	enable = {'typescript', 'javascript'}
      }
    }

    -- One Dark color theme
    use 'navarasu/onedark.nvim'

    use {
      'hrsh7th/vim-vsnip',
      requires = {{'hrsh7th/vim-vsnip-integ'}}
    }

    -- Autocompletion
    use 'hrsh7th/nvim-compe'
    use 'ray-x/lsp_signature.nvim'

    -- Startup screen
    use 'mhinz/vim-startify'

    -- Better session handling
    use {
      'xolox/vim-session',
      requires = {{'xolox/vim-misc'}}
    }

    -- VSCode's lightbulb for neovim
    use 'kosayoda/nvim-lightbulb'
    -- Git helpers
    use 'tpope/vim-fugitive'

    -- Debugging support
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

    require("dapui").setup({
      icons = {
	expanded = "⯆",
	collapsed = "⯈"
      },
      mappings = {
	-- Use a table to apply multiple mappings
	expand = {"<CR>", "<2-LeftMouse>"},
	open = "o",
	remove = "d",
	edit = "e",
      },
      sidebar = {
	elements = {
	  -- You can change the order of elements in the sidebar
	  "scopes",
	  "breakpoints",
	  "watches"
	},
	width = 40,
	position = "left" -- Can be "left" or "right"
      },
 --      tray = {
	-- elements = {
	--   "repl"
	-- },
	-- height = 10,
	-- position = "bottom" -- Can be "bottom" or "top"
 --      },
      floating = {
	max_height = nil, -- These can be integers or a float between 0 and 1.
	max_width = nil   -- Floats will be treated as percentage of your screen.
      }
    })

    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    use 'theHamsta/nvim-dap-virtual-text'

    use 'mbbill/undotree'

    use 'vhdirk/vim-cmake'

    -- Vim list navigation
    use 'tpope/vim-unimpaired'

    -- Snippets
    use 'norcalli/snippets.nvim'	
    require'snippets'.use_suggested_mappings()

    use {
      'amix/vim-zenroom2',
      requires = {{'junegunn/goyo.vim'}}
    }

    -- Auto-indentation detection
    use 'tpope/vim-sleuth'

    use 'junegunn/fzf.vim'
    use 'famiu/bufdelete.nvim'

    use {
      "folke/which-key.nvim",
      config = function()
	require("which-key").setup {
	  plugins = {
	    registers = true
	  }
	}
      end
    }
  end)
