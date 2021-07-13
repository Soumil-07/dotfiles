local g = vim.g

g.session_default_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
g.session_autoload = 'yes'
g.session_autosave = 'yes'
