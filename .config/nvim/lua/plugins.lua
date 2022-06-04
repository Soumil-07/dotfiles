vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use {
		'steelsojka/pears.nvim',
		config = function() require('pears').setup() end
	}

	use {
		'nvim-treesitter/nvim-treesitter',
	}

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp

    use 'tomasiser/vim-code-dark'
end)
