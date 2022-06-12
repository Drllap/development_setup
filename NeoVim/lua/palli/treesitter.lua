require('nvim-treesitter.configs').setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "c", "cpp", "cmake", "dockerfile", "lua", "vim", "python", "json", "yaml"},

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
    additional_vim_regex_highlighting = true,
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
    enable = true,

     -- list of language that will be disabled
    disable = { "python", "cpp" },
  },
}


