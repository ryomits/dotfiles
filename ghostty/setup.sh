#!/bin/bash

mkdir -p "$HOME/.config/ghostty"

if [[ ! -e $HOME/.config/ghostty/config ]]; then
  ln -s "$PWD"/config "$HOME/.config/ghostty/config"
fi
