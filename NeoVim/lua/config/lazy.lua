-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Color schemes
    {
      'gruvbox-community/gruvbox',
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme gruvbox]])
      end,
    },
    {
      'folke/tokyonight.nvim',
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme tokyonight-moon]])
      end,
      enabled = false,
    },

    -- TPope plugins
    { -- Git wrapper plugin
      'tpope/vim-fugitive',
      event = "VeryLazy",
      init  = function()
        vim.g.fugitive_no_maps = 1
      end,
    },
    {  -- Extends/tweaks the vim built in :mksession
      'tpope/vim-obsession',
      event   = "VeryLazy",
      config = function()
        -- vim.cmd([[set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{ObsessionStatus('OB','NS')}\ \ %P]])
      end,
    },
    { 'tpope/vim-dispatch',   event   = "VeryLazy", },  -- Async build
    { 'tpope/vim-surround',   event   = "VeryLazy", },
    { 'tpope/vim-repeat',     event   = "VeryLazy", },
    { 'tpope/vim-commentary', event   = "VeryLazy",   enabled = false  },

    -- TODO this probably can't be lazy, can we do this differently
    -- LSP configuration plugin
    {
      'neovim/nvim-lspconfig',
      -- lazy  = true,
      event  = "VeryLazy",
      config = function()
        require("lsp")
      end,
    },

    -- DAP stuff
    {
      'mfussenegger/nvim-dap',
      event   = "VeryLazy",
      config  = function()
        require("palli.dap")
      end,
      enabled = false,
    },
    {
      'Drllap/visual-studio-integration.vim',
      event   = "VeryLazy",
      enabled = vim.fn.has("win32") == 1,
    },

    -- Completion
    {
      'hrsh7th/nvim-cmp',
      event = "InsertEnter",
      config = function()
        require("auto-completion")
      end,
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-cmdline',
        'onsails/lspkind-nvim',
      },
    },

    -- Treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      event = "VeryLazy",
      config = function()
        require("palli.treesitter")
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      event = "VeryLazy",
      dependencies = 'nvim-treesitter/nvim-treesitter',
    },

    -- Telescope
    {
      'nvim-telescope/telescope.nvim',
      dependencies = 'nvim-lua/plenary.nvim',
      event   = "VeryLazy",
      config  = function()
        -- helpers.safe_require("palli.telescope")
        require("palli.telescope")
      end,
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      event = "VeryLazy",
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    },
    { -- TODO this probably depends on nvim-telescope
      'LukasPietzschmann/telescope-tabs',
      event = "VeryLazy",
      config = function()
        require("palli.telescope-tabs")
      end,
    },

    {
      'preservim/nerdcommenter',
      event = "VeryLazy",
      config = function()
        vim.g.NERDSpaceDelims = 1
      end,
    },

    -- Buffer/Window navigation
    { -- TODO Maybe I should be using this more
      'ggandor/leap.nvim',
      event = "VeryLazy",
      config = function()
        require("palli.leap")
      end,
      enabled = false,
    },
    { -- Jump between windows
      'yorickpeterse/nvim-window',
      event  = "VeryLazy",
      config = function()
        require("palli.nvim-windows")
      end,
    },
    {
      'haya14busa/vim-asterisk',
      event  = "VeryLazy",
      config = require("palli.vim-asterisk"),
    },

    -- File system
    {
      'stevearc/oil.nvim',
      cmd = { "Oil" },
      opts = function() return require("palli.oil") end,
      dependencies = 'kyazdani42/nvim-web-devicons',
    },
    { 'preservim/nerdtree',       enabled = false },
    {
      'kyazdani42/nvim-tree.lua',
      config  = function()
        require("palli.nvim-tree")
      end,
      enabled = false
    },
    {
      'lambdalisue/suda.vim',
      event   = "VeryLazy",
      enabled = vim.fn.has("linux") == 1,
    },

    {
      'lewis6991/gitsigns.nvim',
      event = "VeryLazy",
      opts  = {},
    },
    {
      'voldikss/vim-translator',
      event = "VeryLazy",
      config = function()
        vim.g.translator_target_lang = "en"
        vim.g.translator_source_lang = "is"
      end,
    },
    {
      'jackMort/ChatGPT.nvim',
      event = "VeryLazy",
      opts  = {},
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim",
      },
    },
    {
      'Drllap/gtest.nvim',
      event = "VeryLazy",
      -- dependencies   TODO depends on telescope?
    },


    -- Filetype plugins
    { 'pprovost/vim-ps1',             ft = "ps1" }, -- PowerShell scrip support

    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function() vim.fn["mkdp#util#install"]() end, -- TODO can we remove yarn and npm?
    },

  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "gruvbox" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
