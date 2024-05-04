#!/bin/bash
set -e

# install daily build for neovim
# sudo add-apt-repository ppa:neovim-ppa/unstable
# now installing from source, see below

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt-get update
sudo apt install    \
  git               \
  gh                \
  npm               \
#  neovim            \ building from source, see below
  python3           \
  python3-pip       \
  ninja-build       \
  stow              \
  manpages-posix    \
  build-essential   \
  libtool           \
  autoconf          \
  unzip             \
  wget              \
  clangd-12

pip3 install            \
  pyright               `# Python LSP (Language Server Protocoal) server` \
  cmake-language-server `# CMake LSP server`                              \
  debugpy               `# Python DAP (Debug Adapter Protocoal) server`   \
  conan                                                                   \
  pyreadline            `# Needed for tab autocompletion in python shell`

sudo npm install -g
    vim-language-server
    yarn                `# Used by iamcco/markdown-preview.nvim`

# install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install ripgrep zoxide starship fd-find vivid exa

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

# install cmake from source
# Download
version=3.22
build=2
## don't modify from here
mkdir ~/temp
pushd ~/temp
wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz
tar -xzvf cmake-$version.$build.tar.gz
cd cmake-$version.$build/
# Build and Install
./bootstrap
make -j$(nproc)
sudo make install
popd

# install neovim from source
git clone git@github.com:neovim/neovim.git ../neovim
pushd ../neovim
make CMAKE_BUILD_TYPE=RelWithDebINfo
sudo make install
popd


