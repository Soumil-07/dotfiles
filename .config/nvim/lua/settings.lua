local g = vim.g
local cmd = vim.cmd
local fn = vim.fn
local opt = vim.opt
local bind = vim.api.nvim_set_keymap
local utils = require('utils')

local M = {}

-- Custom grep command
if vim.fn.executable('rg') == 1 then
      opt.grepprg = 'rg --vimgrep --smart-case'
else
      opt.grepprg = 'grep -nH'
end


-- Wildmenu
opt.wildmode = {'longest', 'list', 'full'}
opt.wildmenu = true

-- Hidden buffers
opt.hidden = true

-- Enable mouse support
opt.mouse = 'a'

-- Persistent undo
if vim.fn.exists('~/.vim/undodir') == 0 then
      vim.fn.mkdir(vim.env.HOME..'/.vim/undodir', 'p', 0700)
end
opt.undofile = true
opt.undodir = vim.env.HOME..'/.vim/undodir'

-- Autoread file changes
opt.autoread = true

-- Indent
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Linebreak and wrap behavior
opt.linebreak = true
opt.breakindent = true

-- Line numbers
opt.number = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- For fzf
vim.opt.rtp:append('/opt/homebrew/opt/fzf')

-- Split options
opt.splitbelow = true
opt.splitright = true

-- Something the statusline needs
opt.termguicolors = true

-- Set colorscheme
g.colors_name = 'onedark'
cmd('highlight Pmenu ctermbg=gray guibg=#83a598')

-- Disable using netrw for 'gx' and set it manually
g.netrw_nogx = 1
bind('n', 'gx', '<cmd>!open <cfile><CR>', { noremap = true })


-- Remember last location in file
M.no_restore_cursor_buftypes = {
    'quickfix', 'nofile', 'help', 'terminal'
}

M.no_restore_cursor_filetypes = {
    'gitcommit', 'gitrebase'
}

function M.RestoreCursor()
    if fn.line([['"]]) >= 1 and fn.line([['"]]) <= fn.line('$')
    and not vim.tbl_contains(M.no_restore_cursor_buftypes, vim.bo.buftype)
    and not vim.tbl_contains(M.no_restore_cursor_filetypes, vim.bo.filetype)
    and not vim.fn.bufname() == 'NvimTree'
    then
        cmd('normal! g`" | zv')
    end
end

utils.create_augroup({
    { 'BufReadPost', '*', 'lua require(\'settings\').RestoreCursor()' }
}, 'RestoreCursorOnOpen')

-- Enter insert mode in terminals automatically
utils.create_augroup({
    { 'TermEnter,WinEnter', 'term://*', 'startinsert'}
}, 'TermInsertMode')

return M

