return require("lazy").setup({

    -- UI & Aesthetics
    -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, -- beautiful theme
    {
        "navarasu/onedark.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('onedark').setup {
                style = 'darker'
            }
            -- Enable theme
            require('onedark').load()
        end
    },
    { "nvim-lualine/lualine.nvim" }, -- statusline
    { "nvim-tree/nvim-web-devicons" }, -- file icons

    -- motion
    { "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
        require("leap").add_default_mappings()
        -- Explicitly remap 'S' to leap backward
        local leap = require("leap")
        vim.keymap.set("n", "S", function()
            leap.leap({ backward = true })
        end, { desc = "Leap backward (upward)", noremap = true })
    end,
},

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
                "lua", "python", "bash", "markdown", "verilog", "c", "cpp"
            },
            highlight = { enable = true },
            indent = { enable = false },
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

{
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        check_ts = true,            -- enable Treesitter integration
        disable_filetype = { "TelescopePrompt", "vim" },
        fast_wrap = {},             -- optional: enable fast wrap
    },
},

-- Keybinding Help
{ "folke/which-key.nvim", event = "VeryLazy", config = true },

-- LSP Completion
-- Package manager for LSP servers, linters, formatters
{
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function() require("mason").setup() end,
},
{
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = { "pyright" },
        })
    end,
},

-- LSP client configurations
-- in your plugin spec:
{
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- optional, but highly recommended for completions:
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        -- optional telescope integration:
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        -- bootstrap Mason
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "pyright", "clangd" }, -- add more servers as needed
        })

        -- nvim-cmp capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if has_cmp then
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        end

        -- on_attach will be run for each server
        local on_attach = function(client, bufnr)
            local bufmap = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
            end

            -- jump to definition & hover (you already have these)
            bufmap("n", "gd", vim.lsp.buf.definition,     "Go to definition")
            bufmap("n", "K",  vim.lsp.buf.hover,          "Hover info")

            -- diagnostics
            bufmap("n", "<leader>e", vim.diagnostic.open_float,       "Show line diagnostics")
            bufmap("n", "[d",        vim.diagnostic.goto_prev,        "Prev diagnostic")
            bufmap("n", "]d",        vim.diagnostic.goto_next,        "Next diagnostic")
            bufmap("n", "<leader>q", vim.diagnostic.setloclist,       "Populate loclist")

            -- code action & rename
            bufmap("n", "<leader>ca", vim.lsp.buf.code_action,       "Code action")
            bufmap("v", "<leader>ca", vim.lsp.buf.range_code_action, "Code action (range)")
            bufmap("n", "<leader>rn", vim.lsp.buf.rename,            "Rename symbol")

            -- optionally, if you use telescope.nvim
            -- local has_telescope, ts = pcall(require, "telescope.builtin")
            -- if has_telescope then
            --     bufmap("n", "<leader>ld", ts.diagnostics,               "Telescope diagnostics")
            --     bufmap("n", "<leader>la", ts.lsp_code_actions,         "Telescope code actions")
            -- end

            -- formatting (if supported)
            if client.server_capabilities.documentFormattingProvider then
                bufmap("n", "<leader>f", vim.lsp.buf.format, "Format buffer")
            end
        end

        -- finally, set up each server
        local lspconfig = require("lspconfig")
        for _, server in ipairs({ "pyright", "clangd" }) do
            lspconfig[server].setup({
                on_attach    = on_attach,
                capabilities = capabilities,
            })
        end
    end,
},

-- Completion engine
{
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"]     = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = vim.NIL, -- Uncomment if you want to use Tab for completion
                ["<S-Tab>"] = vim.NIL, -- Uncomment if you want to use Shift-Tab for completion
                -- ["<Tab>"]    = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item()
                    --     elseif luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     else
                    --         fallback()
                    --     end
                    -- end, { "i", "s" }),
                    -- ["<S-Tab>"]  = cmp.mapping(function(fallback)
                        --     if cmp.visible() then
                        --         cmp.select_prev_item()
                        --     elseif luasnip.jumpable(-1) then
                        --         luasnip.jump(-1)
                        --     else
                        --         fallback()
                        --     end
                        -- end, { "i", "s" }),
                    }),
                    sources = cmp.config.sources({
                        { name = "nvim_lsp" },
                        { name = "luasnip" },
                    }, {
                        { name = "buffer" },
                    }),
                })
            end,
        },

        {
            "github/copilot.vim",
            cmd = { "Copilot" },
            enabled = false
        },

        {
            "CopilotC-Nvim/CopilotChat.nvim",
            dependencies = {
                { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
                { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
            },
            build = "make tiktoken", -- Only on MacOS or Linux
            opts = {
                -- See Configuration section for options
            },
            -- See Commands section for default commands if you want to lazy load on them
        },

    })

