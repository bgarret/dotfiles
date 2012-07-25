# Aliases
alias g='git'
compdef g=git
alias gl='git pull'
compdef _git gl=git-pull
alias gp='git push'
compdef _git gp=git-push
alias gg='gitg &'
alias gs='git stash'
alias gsp='git stash pop'
alias nano="vim"
alias restartapp="touch tmp/restart.txt"
alias grep="grep --color=auto"
alias ls="ls --color=auto"

alias sudo="sudo -E"
alias -- +="sudo"
