# Created by newuser for 5.0.5
export LANG=ja_JP.UTF-8

# Color
export LSCOLORS=Exfxcxdxbxegedabagacad
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true

# Prompt
PROMPT='[%n %~]%# '

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

alias vi=vim
alias ll="ls -l"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias j="jobs"
alias f="fg"

DIRSTACKSIZE=100

setopt auto_menu
setopt auto_cd
setopt no_beep
setopt auto_pushd
setopt multios
setopt print_eight_bit
setopt extended_history
setopt hist_reduce_blanks
setopt correct

# Completion
autoload -U compinit
compinit -u

# Command
export PATH=/usr/local/bin:$PATH

# Git
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

# Ruby
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
