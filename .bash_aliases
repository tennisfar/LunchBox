# LUNCHBOX
alias box="cd $LUNCHBOX_ROOT"

alias br="source $LUNCHBOX/.lunchbox ; source $LUNCHBOX/.bash_aliases ; source $LUNCHBOX_ROOT/.bash_aliases ; echo --- reloaded" # Update everything
alias vial='vi $LUNCHBOX/.bash_aliases' # vi aliases
alias vialroot='vi $LUNCHBOX_ROOT/.bash_aliases' # vi root aliases

# Shortcuts
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias findinfiles='find . -type f -print | xargs grep $1'
alias rep="cd $REP"

# GIT
alias sumo="git remote -v && echo git remote set-url origin https://gitlab.com/hpm/REPOSITORY.git" # Update git remote to GitLab

# Not on OSX
if [[ $(uname -s) != Darwin ]]
then
  # Pretty
  alias ll='ls -lhF --color --group-directories-first'
  alias ls='ls -hF --color --group-directories-first'
fi
