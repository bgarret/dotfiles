# Disable extended filename globbing
unsetopt extendedglob

# Arch Linux doesn't autoload the completion by default
autoload -U compinit
compinit

source "$HOME/.zsh/aliases.sh"
source "$HOME/.zsh/git.sh"

autoload colors; colors;
# Setup the prompt with pretty colors
setopt prompt_subst

# number of lines kept in history
export HISTSIZE=1000
# number of lines saved in the history after logout
export SAVEHIST=1000
# location of history
export HISTFILE="$HOME/.zsh_history"
setopt append_history


function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo '○'
}

PROMPT='
%{$fg_bold[blue]%}$(prompt_char)%{$reset_color%}$(git_prompt_info) %{$fg[yellow]%}%m%{$reset_color%} in %{$fg[green]%}$(collapse_pwd)%{$reset_color%}
→ '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}|"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}|%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✓%{$reset_color%}"

# Arch Linux  doesn't source this by default
. "/etc/profile"

# bind special keys according to readline configuration
eval "$(sed -n 's/^/bindkey /; s/: / /p' /etc/inputrc)"

# bindkey "5C" forward-word
# bindkey "5D" backward-word

export EDITOR="vim"
export GEM_OPEN_EDITOR="redcar"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Parse .rvmrc when opening a new terminal
cd .

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/bin
