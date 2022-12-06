#!/usr/bin/env bash

set -eu

for file in .gitconfig .zshrc .tmux.conf
do
	ln -sf "$(pwd)"/$file ~
done
