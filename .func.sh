#!/usr/bin/env bash

funced () { vim + "$HOME/.funcs"; }
ll () { ls -lah; }
la () { ls -A; }
l  () { ls -CF; }
so () { source .venv/bin/activate; }

this-fails () {
    echo foo
    exit 1
    echo bar
}

new-venv () {
    python3 -m venv .venv
    so
    python3 -m pip install --upgrade pip
    python3 -m pip install wheel
}

install-aws-fish () {
    cd /etc/yum.repos.d/
    sudo wget https://download.opensuse.org/repositories/shells:fish:release:3/CentOS_7/shells:fish:release:3.repo
    sudo yum install fish
    cd $HOME
    sudo yum install util-linux-user
    chsh -sh ($which fish)
}

