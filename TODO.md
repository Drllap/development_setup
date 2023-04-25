# TODO
* Reorganise this file:
  * Use `- [ ]` instead of `*` and check the checkbox instead of over lining (~~over lined~~)
  * Put all NeoVim config related items in the **NeoVim** item below:
* NeoVim:
  * Move the .lua config files in NeoVim to a namesapce, palli
  * Create a wrapper for `pcall` that prints error into `:messages` if it fails and use it in the NeoVim config
  * Fix initCommands in dap.rust.lua. `script_import` doesn't point to an existing _lldb_lookup_py_
  * Add health.lua for:
    * lsp config (lua/dap)
      * rust
      * cpp?
      * python?
    * dap config (lua/dap)
      * python
      * rust
      * cpp?
* WezTerm:
  * Make it so I can connect to another domain in the current pan/window. Currently when executing
  `wezterm connect ub/kvikna` it opens a new wezgerm-gui
  * Make it so that a new PS window/pan opens up in the CWD
* PowerShell:
  * Move the PowerShell related things (profile) out of WindowsTerminal folder into a deticated PowerShell folder
* ~~Install DockerCompleteion via PowerShellGallery instead of sub-module~~
* Jump to Visual Studio
* ~~C++ code completion~~
* Report or fix bugs
  * Fix Qt conan packet on Linux when using shared lib option or create a bug report
  * vim/neovim :saveas
  * PowerColor throws when ls-ing in $env:APPDATA/../
  * Planets error on windows
  * Scroll buffer with keybindings
* Install LuaJIT with setup.ps1/.sh
  * Add inspect module to LuaJIT
* ~~Markdown preview~~
* Dictionary/spelling
* Telescope
  * FileExplorer
* Vim FileManager plugin
* Vim org-mode
* Toggle files
  * Toggle between *.cpp/*.h
  * Toggle between autoload/plugin
* Plugins to look into
  * TPope plugins
    * vim-commentary
    * vim-surround
    * vim-repeat
    * vim-scripteas
    * vim-dispatch
    * vim-unimpaired
    * vim-projectionist
    * Maybe some others
  * ToggleTerminal
  * Jira integration: VIRA?
  * GitLab integration: https://github.com/omrisarig13/vim-mr-interface
  * GitHub integration?
* Make vim-plug work with PowerShell (can I run the unit tests?)
* set g:python3_host_prog (see :checkhealth)
* My FileManager plugin
  * Handle when buffer isn't open file
* Vim Status line
* Create build configuration manager.
  * Cpp integration (MsBuild)
  * cmake integration
  * conan integration
* PowerShell
  * ~~Update oh-my-posh, use the executable and cutomaze the theame to my liking~~
  * Use fzf. There is a PS module for it
  * Test/Fix PowerShell $PWD to nix()
  * profile execution optimization
    * See Optimizing your $Profile, https://devblogs.microsoft.com/powershell/optimizing-your-profile/ 
  * change the oh-my-posh prompt in toggle_conda function
  * tab autocomplete
    * ~~conda~~ (I think so at least)
    * conan
    * cmake
* The Vim/NeoVim's modes interface with PowerShell's VI mode when using terminal buffer (:term) with PowerShell
  * Can we de-conflict this somehow?:
    * Don't use Vim insert mode when in :term/Always use it?

