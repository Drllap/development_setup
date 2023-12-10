vim.g.neovide_scale_factor=0.75
vim.api.nvim_create_user_command("FS",
  function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end,
  {}
)
