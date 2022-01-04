# install daily build for neovim
sudo add-apt-repository ppa:neovim-ppa/unstable

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt-get update
sudo apt install    \
  git               \
  gh                \
  neovim            \
  ninja-build       \
  stow

# install vim-plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sv $PWD/NeoVim/ ~/.config/nvim # depends on ~/.config/nvim not existing

git clone https://github.com/sumneko/lua-language-server ../LSP-Servers/lua-language-server
pushd ../LSP-Servers/lua-language-server
git submodule update --init --recursive
cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
popd

