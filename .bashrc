# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

export PATH=/opt/ruby/bin:$PATH
export PATH=/opt/node/bin:$PATH

source $HOME/.git-completion.bash
