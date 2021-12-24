#!/bin/sh
cd $HOME

set -e


sudo npm install -g bash-language-server
sudo npm install -g yaml-language-server

if [[ $OSTYPE == "linux"* ]]; then
    curl -LO https://github.com/neovim/neovim/releases/download/v0.6.0/nvim.appimage
    chmod u+x nvim.appimage
    mkdir -p $HOME/.local/bin
    mv nvim.appimage $HOME/.local/bin/nvim
elif [[ $OSTYPE == "darwin"* ]]; then
    brew install neovim
else
    echo "OS '$OSTYPE' not understood"
    exit 1
fi

if [[ -z $(grep 'alias nvim=' $HOME/.bashrc) ]]; then
    echo "alias nvim='~/.local/bin/nvim.appimage'" >> $HOME/.bashrc
else
    echo "alias for 'nvim' already in $HOME/.bashrc"
fi

if [[ ! -d $HOME/.vim ]]; then
    git clone --recursive git@github.com:renzmann/.vim $HOME/.vim
elif [ -e $HOME/.vim/vimrc ] && [ ! -z "$(grep '" Author: Robert A. Enzmann' $HOME/.vim/vimrc)" ]; then
    echo "Pulling changes from .vim repo"
    cd $HOME/.vim && git pull
    cd $HOME
else
    echo "$HOME/.vim already exists and isn't Robb's - not doing anything!"
fi

if [ ! -d $HOME/.config/nvim ]; then
    git clone --recursive git@github.com:renzmann/config-nvim $HOME/.config/nvim
elif [ -e $HOME/.config/nvim/init.vim ] && [ ! -z "$(grep '" Author: Robert A. Enzmann' $HOME/.config/nvim/init.vim)" ]; then
    echo "Pulling changes from nvim repo"
    cd $HOME/.vim && git pull
    cd $HOME
else
    echo "$HOME/.config/nvim already exists and isn't Robb's - not doing anything!"
fi

if [ ! -d $HOME/.nvim.venv ]; then
    python3 -m venv $HOME/.nvim.venv
fi

export PIPX_BIN_DIR=$HOME/.nvim.venv/bin
source $HOME/.nvim.venv/bin/activate \
    && pip install --upgrade pipx pip black neovim flake8 python-lsp-server[all] \
    && deactivate

if [[ -z $(grep 'export PATH=$HOME/.nvim.venv/bin' $HOME/.bashrc) ]]; then
    echo 'export PATH=$PATH:$HOME/.nvim.venv/bin' >> $HOME/.bashrc
fi

source $HOME/.bashrc
