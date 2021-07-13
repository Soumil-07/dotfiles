local bind = vim.api.nvim_set_keymap
local opts = { noremap = true }

-- Make Y consistent with C and D
bind('n', 'Y', 'y$', opts)

bind('n', 'U', '<C-r>', opts)

-- Don't leave visual mode after indenting
bind('v', '>', '>gv^', opts)
bind('v', '<', '<gv^', opts)

-- Apply the . command to all selected lines in visual mode
bind('v', '.', ':normal .<CR>', opts)

-- Consistent <Esc> behavior in terminal mode
bind('t', '<Esc>', '<C-\\><C-n>', opts)

-- Clear last hl search
bind('n', '<CR>', ':noh<CR><CR>', opts)

-- Floating terminal bindings
bind('n', '<Leader>xa', ':ToggleTermOpenAll<CR>', opts)
bind('n', '<Leader>xc', ':ToggleTermCloseAll<CR>', opts)
bind('n', '<Leader>xx', ':ToggleTerm<CR>', opts)
bind('t', 'xx', '<C-\\><C-n>:ToggleTerm<CR>', opts)

-- Window binds
-- Move between windows
bind('n', '<Leader>wh', ':wincmd h<CR>', opts)
bind('n', '<Leader>wj', ':wincmd j<CR>', opts)
bind('n', '<Leader>wk', ':wincmd k<CR>', opts)
bind('n', '<Leader>wl', ':wincmd l<CR>', opts)

-- Split windows
bind('n', '<Leader>ws', ':wincmd s<CR>', opts)
bind('n', '<Leader>wv', ':wincmd v<CR>', opts)

-- Prevent x from populating registers
bind('n', 'x', '"_x"', opts)

-- fzf.vim bindings
bind('n', '<Leader>ff', ':Files<CR>', opts)
bind('n', '<Leader>fg', ':GFiles<CR>', opts)
bind('n', '<Leader>bf', ':Buffers<CR>', opts)

-- Toggle NvimTree
bind('n', '<Leader>t', ':NvimTreeToggle<CR>', opts)

-- Fugitive mappings
bind('n', '<Leader>gc', ':Git ca<CR>', opts)
bind('n', '<Leader>gpl', ':Git pull<CR>', opts)
bind('n', '<Leader>gp', ':Git push<CR>', opts)
bind('n', '<Leader>gs', ':G<CR>', opts)

-- By default, :bdelete has weird behaviour
bind('n', '<Leader>bd', ':Bdelete!<CR>', opts)
