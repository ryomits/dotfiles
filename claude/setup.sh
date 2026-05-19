#!/bin/bash

if [ ! -e $HOME/.claude ]; then
  mkdir -p $HOME/.claude
fi

if [[ ! -e $HOME/.claude/hooks ]]; then
  ln -s $PWD/hooks $HOME/.claude/hooks
fi

if [[ ! -e $HOME/.claude/agents ]]; then
  ln -s $PWD/agents $HOME/.claude/agents
fi

if [[ ! -e $HOME/.claude/settings.json ]]; then
  ln -s $PWD/settings.json $HOME/.claude/settings.json
fi

mkdir -p $HOME/.claude/skills
for skill_dir in $PWD/skills/*/; do
  skill_name=$(basename "$skill_dir")
  if [[ ! -e $HOME/.claude/skills/$skill_name ]]; then
    ln -s "$skill_dir" "$HOME/.claude/skills/$skill_name"
  fi
done

if [[ ! -e $HOME/.claude/rules ]]; then
  ln -s $PWD/rules $HOME/.claude/rules
fi

if [[ ! -e $HOME/.claude/CLAUDE.md ]]; then
  ln -s $PWD/CLAUDE.md $HOME/.claude/CLAUDE.md
fi
