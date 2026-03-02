local config = {
  gtest_executable = "../build/test/Debug/unit-tests.exe",
  tab_based = true,
  prompt_title = "Run GTest",
}
require('gtest').setup(config)
vim.keymap.set('n', '<leader>tG', function() require('gtest.telescope').run_test() end)
vim.keymap.set('n', '<leader>G' , function() require('gtest').run() end)

