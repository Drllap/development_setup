require('nvim-treesitter.configs').setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "c", "cpp", "rust", "cmake", "dockerfile", "lua", "vim", "python",
                       "json", "yaml", "toml", "markdown", "bash",  "vimdoc", },

  highlight = {
    enable = true,

     -- list of language that will be disabled
    disable = {},

    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      -- ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

--  incremental_selection = {
--    enable = true,
--    keymaps = {
--      init_selecnion    = "gnn",
--      node_incremental  = "grn",
--      scope_incrcmental = "grc",
--      node_decremental  = "grm",
--    },
--  },

  indent = {
    enable = false,
  },

  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobjects, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`. Can also be a function (see above).
      include_surrounding_whitespace = true,
    },
  },
}


