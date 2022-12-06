#!/bin/bash
set -eu

path=~/.vim

if [ ! -e $path ]; then
  mkdir -p $path
fi

if [[ ! -e $HOME/.vimrc ]]; then
  ln -sf "$PWD"/.vimrc "$HOME"/.vimrc
fi

if [[ ! -e $path/template ]]; then
  ln -s "$PWD"/template $path/template
fi
