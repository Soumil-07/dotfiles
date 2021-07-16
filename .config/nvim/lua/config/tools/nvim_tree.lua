local g = vim.g

g.nvim_tree_ignore = {'.git', 'node_modules'}
g.nvim_tree_gitignore = 1
g.nvim_tree_auto_open = 1
g.nvim_tree_auto_close = 1
g.nvim_tree_quit_on_open = 0
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_git_hl = 1

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

g.nvim_tree_bindings = {
    { key = 's', cb = tree_cb('split') },
    { key = 'v', cb = tree_cb('vsplit') }
}
