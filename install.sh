#!/bin/bash

CONF_PATH=$HOME/.myconfig
OH_MY_ZSH=oh-my-zsh
K_VIM=k-vim
export ZSH=$CONF_PATH/$OH_MY_ZSH

if [ -d "$CONF_PATH" ]; then
  printf "You already have env-setup installed.\n"
  printf "You'll need to remove $CONF_PATH if you want to re-install.\n"
  exit
fi

printf "Cloning env-setup...\n"
hash git >/dev/null 2>&1 || {
  echo "Error: git is not installed"
  exit 1
}

env git clone --recursive https://github.com/wengwch/env-setup.git $CONF_PATH || {
  printf "Error: git clone of env-setup repo failed\n"
  exit 1
}

cd $CONF_PATH

# install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf $CONF_PATH/dotfiles/tmux.conf ~/.tmux.conf

cp $CONF_PATH/dotfiles/ssh_config ~/.ssh/config

# install oh my zsh
sh $OH_MY_ZSH/tools/install.sh

# install k-vim
sh $K_VIM/install.sh --for-vim

# change shell
chsh -s `which zsh`

echo 'Done!'
