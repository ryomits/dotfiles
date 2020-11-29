# Created by newuser for 5.0.5
export LANG=ja_JP.UTF-8

# Color
export LSCOLORS=Exfxcxdxbxegedabagacad
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true

# Prompt
PROMPT='%(?,%F{green},%F{red})[%n %~]%#%f '

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

autoload -U compinit vcs_info
compinit -u

alias vi=vim
alias ll="ls -l"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias j="jobs"
alias f="fg"
alias .="source"
alias history="history -i 1"
alias gti="git"

DIRSTACKSIZE=100


zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '[%b]%u%c'
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '-'
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT='%1(v|%F{yellow}%1v%f|)'

setopt auto_menu
setopt auto_cd
setopt no_beep
setopt auto_pushd
setopt multios
setopt print_eight_bit
setopt extended_history
setopt hist_reduce_blanks
setopt correct
setopt extended_history
setopt append_history
setopt inc_append_history
setopt hist_save_no_dups
setopt hist_no_functions
setopt hist_no_store
setopt hist_ignore_dups

export PATH=/usr/local/bin:$PATH
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# openssl
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

source <(kubectl completion zsh)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ryota.mitsui/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ryota.mitsui/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ryota.mitsui/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ryota.mitsui/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/usr/local/sbin:$PATH"
