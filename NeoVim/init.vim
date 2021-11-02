syntax on
set keywordprg=:help " set the Shift+k to use :help, syntax on, above changes it to :Man

set softtabstop=4
set shiftwidth=4
set expandtab
 	
set exrc " local .vimrc files are sorced when doing nvim . 

" set guicursor= " always uses block curser instead of thin line

set splitright " makes new buffer opened in vertical split open on the right side

set relativenumber
set number

set hidden " can jump between buffers without saving

set nowrap

set ignorecase " enable smartcase while searching
set smartcase  " smartcase only workes if ignorecase is enabled

set noswapfile
set nobackup
set undodir=~/.vim/undodir " maybe add plugin called undotree
set undofile

set scrolloff=8 " # lines are always showne above cursor when it is moved up and down

set termguicolors

set colorcolumn=120

call plug#begin(stdpath('data') . '/plugged')
Plug 'pprovost/vim-ps1' " PowerShell scrip support
Plug 'gruvbox-community/gruvbox' " Gruvbox theam
Plug 'tpope/vim-fugitive' " Git wrapper plugin

Plug 'neovim/nvim-lspconfig' " LSP configuration plugin
call plug#end()

colorscheme gruvbox

let g:netrw_liststyle = 3 " NetRW opens with the listings in tree style by default

" Highlights the text that is yanked when in normal mode
augroup LuaHighlight
    au!
    au TextYankPost * silent! lua return (not vim.v.event.visual) and require'vim.highlight'.on_yank()
augroup END


" Create an autocommand that creates the missing folder when writing a file
" that doesn't exist
augroup Mkdir
    autocmd!
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

" Remap Y to yank to the end of the file. Not Vi-compatible but more logical.
" See :h Y
:map Y y$

lua require('init')
