# install daily build for neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt install neovim

# install vim-plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sv $PWD/NeoVim/ ~/.config/nvim # depends on ~/.config/nvim not existing

# setup git
git config --global user.email "drllap@gmail.com"
git config --global user.name "Pall Palsson"
git config --global core.editor "nvim"  
