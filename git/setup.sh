#!/bin/bash

if [[ ! -e $HOME/.gitconfig ]]; then
  ln -s "$PWD"/gitconfig ~/.gitconfig
fi
