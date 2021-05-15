lua require('plugins')

let mapleader = ','
nnoremap <leader>h :noh<CR>
" Map <Esc> in a terminal to escape it
tnoremap <Esc> <C-\><C-n>

" create a directory for persistent undos
if empty(glob('~/.vim/undodir'))
	call mkdir($HOME . "/.vim/undodir", "p", 0700)
endif
set undodir=~/.vim/undodir
set undofile

" reload config every-time this file is written
autocmd BufWritePost init.vim :source $MYVIMRC
" format files with their appropriate formatters
autocmd BufWritePost *.c,*.h :ClangFormat
augroup Python
    autocmd BufWritePost *.py :set expandtab
augroup END

function ReloadPlugins()
	:luafile $HOME/.config/nvim/lua/plugins.lua
	:PackerSync
endfunction

autocmd BufWritePost $HOME/.config/nvim/lua/plugins.lua :call ReloadPlugins()
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" Set :mak depending on the file type
autocmd BufEnter *.py :set makeprg=pylint\ --rcfile\ ~/.pylintrc\ *.py
" autocmd BufEnter *.c,*.h :set makeprg=clang-tidy\ **/*.c
autocmd BufEnter *.ts :set makeprg=yarn\ lint
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

augroup TerminalEnter
    autocmd!
    " Enter edit mode on terminal enter
    autocmd WinEnter term://* :startinsert
augroup END

nnoremap <leader>x :ToggleTerm<CR>
" Make <leader>x work inside a terminal too
tnoremap <leader>x <C-\><C-n>:ToggleTerm<CR>

" for feline
set termguicolors

" <x> shouldn't populate any registers
nnoremap x "_x
" window switching shortcuts
map <C-j> <C-W><Down>
map <C-k> <C-W><Up>
map <C-h> <C-W><Left>
map <C-l> <C-W><Right>
" popup menu colors
highlight Pmenu ctermbg=gray guibg=#83a598

nnoremap <leader>ff <cmd>Files<cr>
nnoremap <leader>fg <cmd>GFiles<cr>
nnoremap <leader>bf <cmd>Buffers<cr>

nnoremap <leader>t <cmd>NERDTreeToggle<cr>
nnoremap <leader>bp <cmd>bp<cr>
nnoremap <leader>bn <cmd>bn<cr>

" setup LSP
lua require 'lsp'
" setup debug helpers
lua require 'debug-helpers'

:command -nargs=+ Pyr :read! python3 -c "print(<args>)"
:command -nargs=+ Pye :! python3 -c "print(<args>)"
:command Esl :! yarn eslint --ext ts --fix %

colorscheme onedark
set number
set mouse=a
set nohidden
set ignorecase
set smartcase
set hidden

imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

lua require'lsp_signature'.on_attach()

if executable('rg') 
	set grepprg=rg\ --vimgrep
endif

let g:dap_virtual_text = v:true

" debugger
nnoremap <leader>dc :lua require'dap'.continue()<CR>
nnoremap <leader>dn :lua require'dap'.step_over()<CR>
nnoremap <leader>dsi lua require'dap'.step_into()<CR>
nnoremap <leader>dst require'dap'.step_out()<CR>
nnoremap <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <leader>dlp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <leader>dl :lua require'dap'.run_last()<CR>
au FileType dap-repl lua require('dap.ext.autocompl').attach()

let g:cmake_export_compile_commands = v:true
let g:session_default_name = fnamemodify(getcwd(), ':t')

" NERDTree conflicts with :bd
noremap <leader>bd :bp<cr>:bd! #<cr>

set rtp+=/opt/homebrew/opt/fzf

" Fugitive mappings
nnoremap <leader>gc :Git ca<CR>
nnoremap <leader>gpl :Git pull<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gs :G<CR>

function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
  echo s:uri
  if s:uri != ""
    silent exec "!open '".s:uri."'"
  else
    echo "No URI found in line."
  endif
endfunction
map <leader>u :call HandleURL()<cr>

nnoremap gs mS:sil!gr "\b<C-r>=expand("<cword>")<CR>\b"<CR>
let g:netrw_nogx = v:true
lua vim.api.nvim_set_keymap('n', 'gx', '<cmd>!open <cfile><CR>', { noremap = true })
