#!/usr/bin/env zsh

for file in .gitconfig .zshrc
do
	ln -sf "$(pwd)"/$file ~
done

brew bundle
source ~/.zshrc

asdf plugin add golang
asdf install golang latest
asdf set golang latest
go install golang.org/x/tools/gopls@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/mattn/efm-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest

asdf plugin add deno
asdf install deno latest
asdf set deno latest

asdf plugin add nodejs
asdf install nodejs latest
asdf set nodejs latest
