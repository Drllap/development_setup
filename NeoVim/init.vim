syntax on
set keywordprg=:help " set the Shift+k to use :help, syntax on, above changes it to :Man

set softtabstop=4
set shiftwidth=4
set expandtab
 	
set exrc " local .vimrc files are sorced when doing nvim . 

set guicursor= " always uses block curser instead of thin line

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
Plug 'gruvbox-community/gruvbox'
call plug#end()

colorscheme gruvbox
