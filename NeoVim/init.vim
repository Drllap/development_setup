syntax on
set keywordprg=:help " set the Shift+k to use :help, syntax on, above changes it to :Man

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

set wildmode=longest:full " tab (wildchar) autocompletes to the longest common string, shows the full list in wildmenu

let mapleader=" "

call plug#begin(stdpath('data') . '/plugged')
Plug 'pprovost/vim-ps1' " PowerShell scrip support
Plug 'gruvbox-community/gruvbox' " Gruvbox theam

" TPope plugins
Plug 'tpope/vim-fugitive'     " Git wrapper plugin
Plug 'tpope/vim-obsession'    " Extends/tweeks the vim built in :mksession
Plug 'tpope/vim-dispatch'     " Async build
" Plug 'tpope/vim-commentary'   " Comment out stuff
Plug 'tpope/vim-surround'

Plug 'neovim/nvim-lspconfig'  " LSP configuration plugin

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'preservim/nerdcommenter'
" Plug 'preservim/nerdtree'
let g:NERDSpaceDelims = 1

" Telescope stuff
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'LukasPietzschmann/telescope-tabs'

" Autocompleation plugins
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'onsails/lspkind-nvim'

" Debug integration plugin
Plug 'mfussenegger/nvim-dap'

" Plug 'ericcurtin/CurtineIncSw.vim'

Plug 'iamcco/markdown-preview.nvim' , { 'do': 'cd app && yarn install' }

Plug 'ggandor/leap.nvim' " Use s to make jumps to some char in view port
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

" Exit insert mode with jk
inoremap <silent> jk <esc>
cnoremap <silent> jk <C-c>
tnoremap <silent> jk <C-\><C-N>

nnoremap <silent> <leader>h <C-w>h
nnoremap <silent> <leader>j <C-w>j
nnoremap <silent> <leader>k <C-w>k
nnoremap <silent> <leader>l <C-w>l

" nnoremap <silent> <C-k><C-b> :NERDTreeToggle<CR>

" Remap Y to yank to the end of the file. Not Vi-compatible but more logical.
" See :h Y
" :map Y y$ " Comment this out because after Nevim v0.6 this is the
" default

if has('win32')
  map <C-z> <Nop>
endif

if has('win32')
  " Add abrivioation to open current file in visual studio

  cabbrev vsedit :!&"C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\devenv.exe" /edit "%"
endif

" Disable spell checking in terminal buffers
augroup MyTerminalGroup
autocmd!
autocmd MyTerminalGroup TermOpen * setlocal nospell
augroup END

lua require('init')

function! ToggleLogging()
  if !&verbose
    execute 'set verbosefile=' .. getcwd() .. '\neovim.log'
    set verbose=13
    echo "Enabling logging"
  else
    set verbose=0
    set verbosefile=
    echo "Disabling logging"
  endif
endfunction
command! -nargs=0 ToggleLogging call ToggleLogging()

function! ResetNvimRC()
  function! SetDefaults()
    compiler! msbuild
    noremap <leader>R :Dispatch ../build/test/Debug/unit-tests.exe<CR>

    noremap <leader>b :silent! :wall <bar> :execute ':Make ' .. '*.sln'->globpath('../build/')<CR>
    noremap <leader>B :silent! :wall <bar> :execute ':Dispatch msbuild ' .. '*.sln'->globpath('../build/')<CR>

    noremap <leader>R :Dispatch ../build/test/Debug/unit-tests.exe<CR>

    noremap <leader>b :silent! :wall <bar> :execute ':Make ' .. '*.sln'->globpath('../build/')<CR>
    noremap <leader>B :silent! :wall <bar> :execute ':Dispatch msbuild ' .. '*.sln'->globpath('../build/')<CR>

    noremap <leader>C         :silent! :wall <bar>
                            \ :execute ":! cmake -B ../build_ninja -S . -G Ninja
                            \                    -DBUILD_TESTING=ON
                            \                    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON 
                            \                    -DCMAKE_MODULE_PATH=" .. "../build_ninja"->fnamemodify(':p')->substitute('\','/','g')<CR>
    noremap <leader><leader>C :silent! :wall <bar>
                            \ :execute ":! cmake -B ../build -S .
                            \                    -DBUILD_TESTING=ON
                            \                    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
                            \                    -DCMAKE_MODULE_PATH=" .. "../build"->fnamemodify(':p')->substitute('\','/','g')<CR>
  endfunction
  call SetDefaults()
  if filereadable(".nvimrc")
    source .nvimrc
  endif
endfunction
call ResetNvimRC()

augroup TabConfigSwitcher
  autocmd!
  autocmd TabEnter * call ResetNvimRC()
augroup END

