#!/usr/bin/env bash

set -u

for file in .gitconfig .zshrc .tmux.conf
do
	ln -sf "$(pwd)"/$file ~
done

brew bundle

asdf plugin add golang
asdf install golang latest
asdf global golang latest
go install golang.org/x/tools/gopls@latest
go install github.com/nametake/golangci-lint-langserver@latest

asdf plugin add deno
asdf install deno latest
asdf global deno latest

asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest
