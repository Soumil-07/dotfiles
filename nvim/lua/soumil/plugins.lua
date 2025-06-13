return require("lazy").setup({

    -- UI & Aesthetics
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, -- beautiful theme
    { "nvim-lualine/lualine.nvim" }, -- statusline
    { "nvim-tree/nvim-web-devicons" }, -- file icons

    -- Status Line

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",        -- Automatically use your colorscheme's colors
                    section_separators = {"", ""},
                    component_separators = {"", ""},
                    icons_enabled = true,
                },
                sections = {
                    lualine_a = {"mode"},
                    lualine_b = {"branch", "diff", "diagnostics"},
                    lualine_c = {"filename"},
                    lualine_x = {"encoding", "fileformat", "filetype"},
                    lualine_y = {"progress"},
                    lualine_z = {"location"},
                },
                inactive_sections = {
                    lualine_c = {"filename"},
                    lualine_x = {"location"},
                },
                tabline = {},
                extensions = {},
            })
        end,
    },

    -- File Explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 35,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
            })
        end,
    },


    -- Fuzzy Finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- Syntax Highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua", "python", "bash", "markdown", "verilog"
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },


    -- Git Integration
    { "lewis6991/gitsigns.nvim" }, -- git diff signs
    { "tpope/vim-fugitive" },      -- Git wrapper

    -- Commenting
    { "numToStr/Comment.nvim", config = true },

    -- LSP + Autocompletion
    {
        "neovim/nvim-lspconfig", -- LSP configs
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
            "hrsh7th/nvim-cmp",         -- Completion engine
            "L3MON4D3/LuaSnip",         -- Snippet engine
            "saadparwaiz1/cmp_luasnip", -- Snippets in completion
            "hrsh7th/cmp-buffer",       -- Buffer source
            "hrsh7th/cmp-path",         -- Path source
        }
    },

    -- Keybinding Help
    { "folke/which-key.nvim", event = "VeryLazy", config = true },

})

