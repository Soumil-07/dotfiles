vim.o.number = true
vim.o.mouse = 'a'
vim.o.swapfile = false
vim.o.undofile = true

vim.o.expandtab = true          -- Use spaces instead of tabs
vim.o.shiftwidth = 4            -- Number of spaces per indent
vim.o.tabstop = 4               -- Number of spaces per tab
vim.o.smartindent = true        -- Smart autoindenting
vim.o.wrap = false              -- Disable line wrapping
vim.o.scrolloff = 8             -- Keep cursor 8 lines from screen edge
vim.o.sidescrolloff = 8

vim.o.ignorecase = true         -- Ignore case in search
vim.o.smartcase = true          -- Override ignorecase if capital letter
vim.o.incsearch = true          -- Show matches while typing
vim.o.hlsearch = false          -- Don't highlight matches after search

vim.o.termguicolors = true      -- True color support
vim.o.signcolumn = "yes"        -- Always show sign column
vim.o.cursorline = true         -- Highlight current line
vim.o.colorcolumn = "80"        -- Show guide at 80 characters
vim.o.splitright = true         -- Vertical splits to the right
vim.o.splitbelow = true         -- Horizontal splits below

vim.opt.completeopt = {"menu", "menuone", "noselect"}  -- Better completion experience
vim.o.hidden = true              -- Allow buffer switching without saving
vim.o.autoread = true            -- Auto-reload file changed outside
vim.o.showmode = false           -- Don't show --INSERT-- etc
vim.o.laststatus = 3             -- Global statusline

vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Navigate to next buffer
map("n", "]b", ":bnext<CR>", opts)

-- Navigate to previous buffer
map("n", "[b", ":bprev<CR>", opts)

-- Delete (close) current buffer
map("n", "<leader>bd", ":bdelete<CR>", opts)

-- Save file
map("n", "<leader>w", ":write<CR>", opts)

-- Window cmd shortcuts
map("n", "wh", ":wincmd h<CR>", opts)
map("n", "wl", ":wincmd l<CR>", opts)
map("n", "wk", ":wincmd k<CR>", opts)
map("n", "wj", ":wincmd j<CR>", opts)

-- Save and quit
map("n", "<leader>x", ":write | quit<CR>", opts)

-- Quit without saving
map("n", "q", ":quit<CR>", opts)

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
      vim.cmd("quit")
    end
  end
})

