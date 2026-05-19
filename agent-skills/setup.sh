#!/bin/bash
set -euo pipefail

if [ ! -e $HOME/.agents ]; then
  mkdir -p $HOME/.agents
fi

if [[ ! -e $HOME/.agents/.skill-lock.json ]]; then
  ln -s $PWD/skill-lock.json $HOME/.agents/.skill-lock.json
fi

npx -y skills@latest experimental_install
